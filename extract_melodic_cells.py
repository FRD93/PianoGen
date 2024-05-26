import numpy as np
import matplotlib.pyplot as plt


a = np.array([ 72, 72, 77, 77, 76, 79, 82, 72, 74, 76, 81, 72, 74, 74, 74, 79, 77, 74, 72, 79, 77, 76, 77, 74, 74, 77, 79, 72, 72, 82, 81, 79, 81, 72, 74, 76, 81, 82, 72, 76, 82, 81, 79, 77, 81, 82, 74, 76, 76, 72, 76, 72, 76, 77, 81, 72, 77, 74, 81, 77, 76, 82, 81, 79, 72, 82, 81, 79, 79, 82, 76, 74, 82, 81, 76, 74, 72, 79, 77, 72, 77 ])
#a = np.array([ 82, 74, 74, 82, 72, 82, 81, 79, 76, 74, 72, 79, 79, 77, 76, 81, 81, 81, 82, 76, 76, 82, 72, 82, 81, 77, 77, 81, 81, 81 ])

plt.plot(a)
plt.title("Melodic Line")
plt.show()

b = np.array([np.roll(a, -1 * i) == a for i in range(1, len(a))])
b = np.concatenate((np.array([[False]] * b.shape[1]).T, b), axis=0)
c = np.array([[(v == True) and (vec[i+1] == True) for i,v in enumerate(vec[:-1])] for vec in b])
c = np.concatenate((c, np.array([[False]] * c.shape[0])), axis=1)
d = np.array([[True if ((vec[i] == False) and (vec[i-1] == True) and (vec[i-2] == True)) else vec[i] for i in range(1, len(vec))] for vec in c])
d = np.concatenate((d, np.array([[False]] * d.shape[0])), axis=1)
e = np.array([[False if ((vec[i-1] == False) and (vec[i] == True) and (vec[i+1] == False)) else vec[i] for i in range(1, len(vec)-1)] for vec in d])
e = np.concatenate((e, np.array([[False]] * e.shape[0])), axis=1)
e = np.concatenate((e, np.array([[False]] * e.shape[0])), axis=1)
plt.matshow(e)
plt.title("Autocorrelation of Melodic Line")
plt.show()
f = np.sum(e, axis=0)


plt.matshow(np.array([f, f]))
plt.title("All Matches")
plt.show()

plt.matshow(np.array([f, f]) >= np.amax(f))
plt.title("Resulting Melodic Cells")
plt.show()
