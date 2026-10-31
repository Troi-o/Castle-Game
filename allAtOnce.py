import random
import heapq
import matplotlib.pyplot as plt
import numpy as np

#AI data
modelAns = [[0,0,20,35,45],
            [0,0,15,35,50],
            [10,15,20,25,30],
            [0,12,23,30,35],
            [0,1,26,36,37],
            [0,3,18,38,41],
            [1,2,29,33,35],
            [0,15,22,29,34]]

#generate random bullshit
randomAns = []
randLen = 1000
for i in range(randLen):
    cuts = sorted(random.randint(0, 100) for _ in range(4))
    row = [cuts[0], cuts[1]-cuts[0], cuts[2]-cuts[1], cuts[3]-cuts[2], 100-cuts[3]]
    randomAns.append(row)

for i in range(randLen):
    randomAns[i] = [0,0,0,0,0]
    order = random.sample(range(0,5), 5)

    total = 0
    for j in range(0, len(order)):
        if(j == len(order) - 1):
            randomAns[i][order[j]] = 100 - total
        else:
            randomAns[i][order[j]] = random.randint(0, 100 - total)
        total += randomAns[i][order[j]]



#pit strats against each other
combined = modelAns + randomAns
scores = [0] * len(combined)

for i in range(len(combined)):
    for j in range(i + 1, len(combined)):   # each pair once, never against itself
        a, b = combined[i], combined[j]
        for indx in range(len(a)):
            if a[indx] > b[indx]:
                scores[i] += indx
            elif b[indx] > a[indx]:
                scores[j] += indx

#match scores to best performing models
N = 50
top_indices = heapq.nlargest(N, range(len(scores)), key=lambda i: scores[i])

best_strategies = [combined[i] for i in top_indices]
best_scores = [scores[i] for i in top_indices]

print(best_strategies)


#graph this shit
def graph():
    positions = [1, 2, 3, 4, 5]

    all_avg = np.mean(combined, axis=0)          # average per position, all strategies
    best_avg = np.mean(best_strategies, axis=0)  # average per position, top 50 only

    x = np.arange(len(positions))
    width = 0.4

    plt.bar(x - width/2, all_avg, width, label="All strategies")
    plt.bar(x + width/2, best_avg, width, label=f"Top {N}")

    plt.xticks(x, positions)
    plt.xlabel("Position")
    plt.ylabel("Average value")
    plt.title("Average allocation per position")
    plt.legend()
    plt.show()


graph()