import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator
from lldb import debugger

def current_frame():
    return debugger.GetSelectedTarget().GetProcess().GetSelectedThread().GetSelectedFrame()

def to_nparray(variable_name):
    # Get size
    expr = "{}.size()".format(variable_name)
    size = int(current_frame().EvaluateExpression(expr).GetValue())

    # Get data
    data = np.zeros(size, dtype = float)
    for idx in np.arange(0, size):
        expr = "{}[{}]".format(variable_name, idx)
        data[idx] = float(current_frame().EvaluateExpression(expr).GetValue())
    return data

def plot(debugger, command, result, internal_dict):
    """
    Plots a variable available in the current frame.
    """
    if '--help' == command:
        print("Plots a variable available in the current frame.")
        print("Usage:")
        print("dplot <x>, <y>")
        print("dplot --show")
    elif '--show' == command:
        plt.show()
        return
    else:
        variable_names = [name.strip(' ') for name in command.split(',')]
        ax = plt.figure().gca()
        y_min = None
        y_max = None
        for variable_name in variable_names:
            a = to_nparray(variable_name)
            idx = np.arange(0, len(a))
            plt.step(idx, a, label = variable_name)
            plt.xlim([-1, len(a)])
            y_min = np.amin(a) if y_min is None else min(y_min, np.amin(a))
            y_max = np.amax(a) if y_max is None else max(y_max, np.amax(a))
        if y_min >= 0:
            plt.ylim([0, y_max+1])
        else:
            plt.ylim([y_min-1, y_max+1])
        ax.xaxis.set_major_locator(MaxNLocator(integer=True))
        plt.legend()

def plot_show():
    plt.show()
    
    # expr = "print {}".format(variable_name)
    # var = current_frame().FindVariable(variable_name)
    # print(var.GetType())

def __lldb_init_module(debugger, internal_dict):
    debugger.HandleCommand('command script add -f dbg.plot dplot')

