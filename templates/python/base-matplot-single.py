import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import CUDO_colors
from matplotlib.ticker import ScalarFormatter
plt.rcParams['font.family']      = 'Times New Roman'
plt.rcParams['mathtext.fontset'] = 'stix'
plt.rcParams['text.usetex']      = True
plt.rcParams['text.latex.preamble'] = r'\usepackage{amsmath}'
plt.rcParams['font.size']        = 12
plt.rcParams['xtick.direction']  = 'in'
plt.rcParams['ytick.direction']  = 'in'
plt.rcParams['legend.frameon']   = False

formatter = ScalarFormatter(useMathText=True)
formatter.set_scientific(True)
formatter.set_powerlimits((-1, 1))

width = 90 / 25.4
fig, ax = plt.subplots(1, 1, figsize=(width, width / 4 * 3))


{{_cursor_}}

ax.set_xlabel('x')
ax.set_ylabel('y')

plt.tight_layout()
plt.savefig('Fig_{{_name_}}_original.png', transparent=True, dpi=300)
plt.savefig('Fig_{{_name_}}_original.pdf', transparent=True)
plt.savefig('Fig_{{_name_}}_original.svg', transparent=True)
plt.show()
