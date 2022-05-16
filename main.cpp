#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <unistd.h>

using namespace std;

vector<string> dscp {"0x00", "0xFC", "0xF8", "0xF4", "0xF0",
                             "0xEC", "0xE8", "0xE4", "0xE0",
                             "0xDC", "0xD8", "0xD4", "0xD0",
                             "0xCC", "0xC8", "0xC4", "0xC0",
                             "0xBC", "0xB8", "0xB4", "0xB0",
                             "0xAC", "0xA8", "0xA4", "0xA0",
                             "0x9C", "0x98", "0x94", "0x90",
                             "0x8C", "0x88", "0x84", "0x80",
                             "0x7C", "0x78", "0x74", "0x70",
                             "0x6C", "0x68", "0x64", "0x60",
                             "0x5C", "0x58", "0x54", "0x50",
                             "0x4C", "0x48", "0x44", "0x40",
                             "0x3C", "0x38", "0x34", "0x30",
                             "0x2C", "0x28", "0x24", "0x20"
                             "0x1C", "0x18", "0x14", "0x10",
                             "0x0C", "0x08", "0x04" };
int duration;
vector<int> prio;
vector<int> coflowToPrio(1);
vector<string> ipAddress;

vector<string> loadIPAddressesFromFile(string fileName) {
    ifstream instance(fileName);
    if(!instance.is_open()) throw runtime_error("Could not open file");
    vector<string> ipa;
    string line;
    ipa.push_back("");
    while(getline(instance, line)) {
        stringstream flow(line);
        ipa.push_back(line);
    }
    instance.close();
    return(ipa);
}

int getDuration(string fileName) {
    ifstream instance(fileName);
    if(!instance.is_open()) throw runtime_error("Could not open file");
    int maximum = 0;
    string line;
    int data;
    getline(instance, line);
    getline(instance, line);
    stringstream flow(line);
    while(flow >> data) {
        if (data > maximum) maximum = data;
        if(flow.peek() == ',') flow.ignore();
    }
    instance.close();
    return(maximum*1.2);
}

string buildIperfSenderCommand(vector<int> flow) {
    return "ssh PC"+to_string(flow[1])+
           " iperf -c "+ipAddress[flow[2]]+" -n "+to_string(flow[3]*1.25)+"M -S "+dscp[coflowToPrio[flow[0]]+11]+" > /dev/null 2> logs/out/"+to_string(flow[0])+"_"+to_string(flow[1])+"to"+to_string(flow[2])+".txt &\n"; // /dev/null 2>&1;
}

vector<vector<int>> loadFlowsFromFile (const string& fileName) {
    ifstream instance(fileName);
    if(!instance.is_open()) throw runtime_error("Could not open file");
    vector<vector<int>> flows;
    string line;
    int data, index=0;
    getline(instance, line);
    while(getline(instance, line)) {
        flows.emplace_back();
        stringstream flow(line);
        while(flow >> data) {
            flows.at(index).push_back(data);
            if(flow.peek() == ',') flow.ignore();
        }
        index++;
    }
    instance.close();
    for(auto & flow : flows) {
        flow.erase(flow.begin());
        flow.pop_back();
        flow.front()++;
    }
    return(flows);
}

vector<int> loadPrioFromFile (const string& fileName) {
    ifstream instance(fileName);
    if(!instance.is_open()) throw runtime_error("Could not open file");
    vector<int> prio;
    string line;
    int data;
    getline(instance, line);
    getline(instance, line);
    stringstream flow(line);
    while(flow >> data) {
        prio.push_back(data);
        if(flow.peek() == ',') flow.ignore();
    }
    instance.close();
    return(prio);
}

void setCoflowToPrio(vector<vector<int>>& flows, const vector<int>& prio) {
    coflowToPrio.resize(prio.size()+1);
    for (int i=0; i<prio.size(); i++) {
        coflowToPrio[prio[i]] = i+1;
    }
    sort(flows.begin(), flows.end(), [&](const auto& a, const auto& b) {
        return coflowToPrio[a[0]] < coflowToPrio[b[0]];
    });
}

int getMachineNumber(const vector<vector<int>>& flows) {
    int machineNumber = 0;
    for (auto & flow : flows) {
        machineNumber = flow[1] > machineNumber ? flow[1] : machineNumber;
        machineNumber = flow[2] > machineNumber ? flow[2] : machineNumber;
    }
    return machineNumber++;
}

void sender(const vector<vector<int>>& flows, bool tcp) {
    int machineNumber = getMachineNumber(flows);
    vector<bool> isListening(machineNumber, false);
    string command;
    char* cmd;
    ofstream script("launcher.sh", ofstream::trunc);
    script << "#!/bin/bash\n\n";
    for(auto & flow : flows) {
        isListening[flow[2]] = true;
        script << buildIperfSenderCommand(flow);
    }
    script.close();
    {
        ofstream scheduler("prioritization.sh", ofstream::trunc);
        for (int i=1; i<=machineNumber; i++) {
            if (tcp == false) {
                scheduler << "scp ~/Work/multipass/tc_prio.sh PC"+to_string(i)+":~ && ssh PC"+to_string(i)+" sudo bash tc_prio.sh &\n";
            }
            else {
                scheduler << "scp ~/Work/multipass/tc_vanilla.sh PC"+to_string(i)+":~ && ssh PC"+to_string(i)+" sudo bash tc_vanilla.sh &\n";
            }
            if (isListening[i]) {
                command = "ssh PC"+to_string(i)+" iperf -s | ts %H:%M:%.S > logs/in/log"+to_string(i)+".txt &";
                cmd = &command[0];
                system(cmd);
            }
        }
    }
    system("bash prioritization.sh >> /dev/null 2>&1");
    sleep(10);
    command = "bash launcher.sh";
    cmd = &command[0];
    system(cmd);
    sleep(duration);
    for (int i=1; i<=machineNumber; i++) {
        if (isListening[i]) {
            command = "ssh PC"+to_string(i)+" killall iperf -9";
            cmd = &command[0];
            system(cmd);
        }
    }
}

int main() {
    for (int i=1; i<2; i++) {
        cout<<"start "<<i<<endl;
        system("rm logs/in/*.txt");
        system("rm logs/out/*.txt");
        string instanceName = "toy";
        string algo = "";
        bool tcp = false;
        ipAddress = loadIPAddressesFromFile("config/iptable.txt");
        duration = getDuration("instances/"+instanceName+"_cct"+algo+".csv");
        prio = loadPrioFromFile("instances/"+instanceName+"_prio"+algo+".csv");
        vector<vector<int>> flows = loadFlowsFromFile("instances/"+instanceName+".csv");
        setCoflowToPrio(flows, prio);
        sender(flows, tcp);
        if (algo == "") algo = "1";
        system(("python3 time.py "+instanceName+" "+algo+" "+to_string(i)+" "+to_string(prio.size())).c_str());
        cout<<"end "<<i<<endl;
        sleep(2);
    }
    return 0;
}
