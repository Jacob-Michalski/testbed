#pragma once

#include <utility>

using namespace std;

class TC {
    public : string command;
    protected : string commonPart;

    protected : explicit TC(const string& netInt) {
        command = "tc";
        commonPart = "add dev " + netInt;
    }
};

class TCqdisc : public TC {

    public : explicit TCqdisc(const string& netInt) : TC(netInt) {
        command.append(" qdisc "+commonPart);
    }

};

class TCqdiscRoot : public TCqdisc {

    public : explicit TCqdiscRoot(const string& netInt, const string& options) : TCqdisc(netInt) {
        command.append(" root handle 1: "+options+"\n");
    }

};

class TCqdiscParent : public TCqdisc {

    public : explicit TCqdiscParent(const string& netInt, const string& parentNum, const string& handleNum, const string& options) : TCqdisc(netInt) {
        command.append(" parent "+parentNum+" handle "+handleNum+" "+options+"\n");
    }

};

class TCclass : public TC {

    public : explicit TCclass(const string& netInt, const string& parentNum, const string& classNum, const string& options) : TC(netInt) {
        command.append(" class "+commonPart+" parent "+parentNum+ " classid "+classNum+" "+options+"\n");
    }

};

class TCfilter : public TC {

    public : explicit TCfilter(const string &netInt, const string& parentNum, const string& prioNum, const string& options) : TC(netInt) {
        command.append(" filter "+commonPart+" protocol ip parent "+parentNum+" prio "+prioNum+" "+options+"\n");
    }

};
