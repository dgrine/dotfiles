import pandas as pd
import numpy as np
import tempfile
import os
import subprocess
import shutil


def _launch_vd(feather_path):
    cmd = ["vd", feather_path]
    if shutil.which("tmux") and os.getenv("TMUX"):
        subprocess.Popen(["tmux", "split-window", "-v", *cmd])
    else:
        subprocess.Popen(cmd)


def vd(obj):
    if isinstance(obj, np.ndarray):
        if obj.ndim == 1:
            obj = obj.reshape(-1, 1)
        obj = pd.DataFrame(obj)
    elif not isinstance(obj, pd.DataFrame):
        print(f"[vd] Unsupported type: {type(obj).__name__}")
        return

    path = tempfile.mktemp(suffix=".feather")
    try:
        obj.reset_index().to_feather(path)
    except Exception as e:
        print(f"[vd] Error writing feather file: {e}")
        return

    _launch_vd(path)
    print(f"[vd] Opened in VisiData: {path}")
