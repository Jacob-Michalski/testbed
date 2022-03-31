import matplotlib.pyplot as plt
import numpy as np
from tabulate import tabulate

def graph(name, algo, nr, coflowNumber):

    results = np.genfromtxt(f"times/{name}/{name}{algo}_({nr}).csv", delimiter=",", skip_header=1)
    expected = np.genfromtxt(f"instances/{name}_cct{algo}.csv", delimiter=",", skip_header=1)

    times = {}
    for coflow in range(1, coflowNumber+1):
        times[coflow] = float('0.0')

    for line in results:
        coflow = int(line[0])
        times[coflow] = max(times[coflow], line[3])

    coflows = list(str(coflow) for coflow in times.keys())
    times = np.array(list(times.values()))
    expected_times = np.array(list(expected))

    with open(f"times/{name}/{name}_{algo}_({nr}).txt", 'w') as cct:
        for time in times:
            cct.write(str(time)+'\n')
        cct.write('\n')
        for i in range (coflowNumber):
            cct.write(str((times[i]-expected_times[i])/coflowNumber)+'\n')

    print(times)
    print()
    print((times / expected_times)*100 - 100)

    plt.bar(coflows, times, align="edge", width=0.3)
    plt.bar(coflows, expected_times, align="edge", width=-0.3)
    plt.savefig(f"graphs/{name}/{name}{algo}_({nr}).png")
