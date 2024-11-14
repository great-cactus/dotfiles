import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
plt.rcParams['font.family']      = 'Times New Roman'
plt.rcParams['mathtext.fontset'] = 'stix'
plt.rcParams['font.size']        = 10
plt.rcParams['xtick.direction']  = 'in'
plt.rcParams['ytick.direction']  = 'in'

{{_cursor_}}
x = np.linspace(0, 1, 100)
y = np.sin(x)

width = 90 / 25.4
fig, ax = plt.subplots(1,1, figsize=(width, width/4*3))
ax.plot(x, y, color='black')

ax.set_xlabel('x')
ax.set_ylabel('y')

plt.tight_layout()
plt.savefig('Fig_{{_name_}}.png', dpi=300)
plt.show()
