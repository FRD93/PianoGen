import numpy as np
import matplotlib.pyplot as plt


a = np.array([[ 72, 1 ],[ 72, 1 ],[ 77, 1 ],[ 77, 1 ],[ 76, 0.5 ],[ 79, 0.5 ],[ 82, 0.5 ],[ 72, 0.5 ],[ 74, 0.5 ],[ 76, 0.5 ],[ 81, 0.5 ],[ 72, 0.5 ],[ 74, 1 ],[ 74, 1 ],[ 74, 1 ],[ 79, 1 ],[ 77, 0.5 ],[ 74, 1 ],[ 72, 0.5 ],[ 79, 1 ],[ 77, 0.5 ],[ 76, 0.5 ],[ 77, 1 ],[ 74, 1 ],[ 74, 1 ],[ 77, 1 ],[ 79, 0.5 ],[ 72, 1 ],[ 72, 0.5 ],[ 82, 1 ],[ 81, 0.5 ],[ 79, 0.5 ],[ 81, 0.5 ],[ 72, 0.5 ],[ 74, 0.5 ],[ 76, 0.5 ],[ 81, 0.5 ],[ 82, 0.5 ],[ 72, 0.5 ],[ 76, 0.5 ],[ 82, 0.5 ],[ 81, 0.5 ],[ 79, 0.5 ],[ 77, 0.5 ],[ 81, 0.5 ],[ 82, 0.5 ],[ 74, 0.5 ],[ 76, 0.5 ],[ 76, 1 ],[ 72, 1 ],[ 76, 1 ],[ 72, 1 ],[ 76, 0.25 ],[ 77, 0.5 ],[ 81, 0.25 ],[ 72, 0.5 ],[ 77, 1 ],[ 74, 1.5 ],[ 81, 0.5 ],[ 77, 1 ],[ 76, 0.5 ],[ 82, 1 ],[ 81, 0.5 ],[ 79, 0.5 ],[ 72, 0.25 ],[ 82, 0.5 ],[ 81, 0.25 ],[ 79, 0.5 ],[ 79, 1 ],[ 82, 1.5 ],[ 76, 0.5 ],[ 74, 0.5 ],[ 82, 0.5 ],[ 81, 0.5 ],[ 76, 0.5 ],[ 74, 0.5 ],[ 72, 0.5 ],[ 79, 0.5 ],[ 77, 1 ],[ 72, 1 ],[ 77, 1 ],])
#a = np.array([ 82, 74, 74, 82, 72, 82, 81, 79, 76, 74, 72, 79, 79, 77, 76, 81, 81, 81, 82, 76, 76, 82, 72, 82, 81, 77, 77, 81, 81, 81 ])

#plt.plot(a)
#plt.title("Melodic Line")
#plt.show()
#b = np.array([np.roll(a, -1 * i) == a for i in range(1, len(a))])
b = np.array([np.equal(np.roll(a, -1 * i), a) for i in range(1, len(a))])
bf = np.zeros((b.shape[0], b.shape[1]))
for xi in range(b.shape[0]):
	for yi in range(b.shape[1]):
		bf[xi, yi] = True if (b[xi, yi][0] == True) and (b[xi, yi][1] == True) else False
b = bf
#b = np.sum(b, axis=2) # cambiare questo, perchè True+False=True, mentre io voglio =False
print(b)
b = np.concatenate((np.array([[False]] * b.shape[1]).T, b), axis=0)
c = np.array([[(v == True) and (vec[i+1] == True) for i,v in enumerate(vec[:-1])] for vec in b])
c = np.concatenate((c, np.array([[False]] * c.shape[0])), axis=1)
d = np.array([[True if ((vec[i] == False) and (vec[i-1] == True) and (vec[i-2] == True)) else vec[i] for i in range(2, len(vec))] for vec in c])
d = np.concatenate((d, np.array([[False]] * d.shape[0])), axis=1)
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
