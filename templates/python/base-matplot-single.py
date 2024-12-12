import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import ScalarFormatter
plt.rcParams['font.family']      = 'Times New Roman'
plt.rcParams['mathtext.fontset'] = 'stix'
plt.rcParams['text.usetex']      = True
plt.rcParams['text.latex.preamble'] = r'\usepackage{amsmath}'
plt.rcParams['font.size']        = 10
plt.rcParams['xtick.direction']  = 'in'
plt.rcParams['ytick.direction']  = 'in'

formatter = ScalarFormatter(useMathText=True)
formatter.set_scientific(True)
formatter.set_powerlimits((-1,1))

width = 90 / 25.4
fig, ax = plt.subplots(1,1, figsize=(width, width/4*3))


{{_cursor_}}
x = np.linspace(0, 1, 100)
y = np.sin(x)

ax.plot(x, y, color='black')

ax.set_xlabel('x')
ax.set_ylabel('y')

plt.tight_layout()
plt.savefig('Fig_{{_name_}}.png', transparent=True, dpi=300)
plt.savefig('Fig_{{_name_}}.pdf', transparent=True)
plt.show()
