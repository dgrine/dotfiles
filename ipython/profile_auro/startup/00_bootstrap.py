import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
plt.ion()
from pathlib import Path
import os
import sys

sys.path.append(f"{os.getcwd()}/core/build/python")
import auro.build.bootstrap

print("Tip: For automatic reloading and interactive plots, use:")
print("%load_ext autoreload")
print("%autoreload 2")
