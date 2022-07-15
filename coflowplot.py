import matplotlib.pyplot as plt
import numpy as np
import csv, os

def graph(name, algo, nr, coflowNumber):

    results = np.genfromtxt(f"times/{name}/{name}{nr}{algo}.csv", delimiter=",", skip_header=1)
    expected = np.genfromtxt(f"instances/{name}/{name}{nr}_cct{algo}.csv", delimiter=",", skip_header=1)

    times = {}
    for coflow in range(1, coflowNumber+1):
        times[coflow] = float('0.0')

    for line in results:
        coflow = int(line[0])
        times[coflow] = max(times[coflow], line[3])

    coflows = list(str(coflow) for coflow in times.keys())
    times = np.array(list(times.values()))
    expected_times = np.array(list(expected))

    if not os.path.isdir(f"graphs/{name}"):
        os.mkdir(f"graphs/{name}")
    with open(f"times/{name}/{name}{nr}{algo}_cct.csv", 'a+') as content:
        ccts = csv.writer(content)
        ccts.writerow(times)

    print(times)

    # plt.bar(coflows, times, align="edge", width=0.3)
    # plt.bar(coflows, expected_times, align="edge", width=-0.3)
    # plt.savefig(f"graphs/{name}/{name}{nr}{algo}.png")
    # plt.clf()