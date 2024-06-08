

# import scipy io to read the .mat file
import scipy.io as sio
import numpy as np

# load the .mat file
naca0012_sweep = sio.loadmat('Data/0012_swp.mat')

# print the contents of the .mat file
print(naca0012_sweep.keys())

alpha = naca0012_sweep['alpha'][0,:]
cl = naca0012_sweep['Cl_s'][0,:]
cd = naca0012_sweep['Cd_s'][0,:]


# import matplotlib.pyplot to plot the data
import matplotlib.pyplot as plt

plt.rcParams['figure.dpi'] = 300
plt.rcParams["text.usetex"] = True
plt.rcParams["font.family"] = "serif"
plt.rcParams['figure.facecolor'] = 'white'

plt.figure(figsize=(6, 8))

# plot the data

plt.plot(alpha, cl, label='Cl', color='red')

xticks = np.arange(-24, 36, 4, )
plt.xticks(xticks)
plt.xlim(-24, 32)
yticks = np.arange(-1.8, 2.8, 0.4)
plt.yticks(yticks)
plt.ylim(-1.8, 2.8)

# plot image
img = plt.imread('exercises/week3/NACA0012_background.png')
plt.imshow(img, extent=[-24, 32, -1.8, 2.8], aspect='auto')

plt.xlabel('Angle of Attack (degrees)')
plt.ylabel('Coefficient')
plt.title('NACA 0012 Airfoil Data')

plt.legend()

# save the plot
plt.savefig('NACA0012_lift_validation.png', dpi=300, bbox_inches='tight')



plt.figure(figsize=(6, 8))

# plot the data

plt.plot(cl, cd, label='Cl', color='red')

xticks = np.arange(-1.6, 1.6, 0.4)
plt.xticks(xticks)
plt.xlim(-1.6, 1.6)
yticks = np.arange(0, 0.032, 0.004)
plt.yticks(yticks)
plt.ylim(0, 0.032)

# plot image
img = plt.imread('exercises/week3/NACA0012_background2.png')
plt.imshow(img, extent=[-1.6, 1.6, 0, 0.032], aspect='auto')

plt.xlabel('Angle of Attack (degrees)')
plt.ylabel('Coefficient')
plt.title('NACA 0012 Airfoil Data')

plt.legend()


# save the plot
plt.savefig('NACA0012_drag_validation.png', dpi=300, bbox_inches='tight')


plt.show()