import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
plt.ion()
from pathlib import Path
import sys

sys.path.append(f"{Path.home()}/dev/repos/all/core/build/python")
import auro.build.bootstrap

print("Tip: For automatic reloading and interactive plots, use:")
print("%load_ext autoreload")
print("%autoreload 2")
