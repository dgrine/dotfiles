import json
import os
import subprocess
import tempfile


def plot_column(sheet):
    col = sheet.cursorCol
    key_cols = getattr(sheet, "keyCols", [])

    x = []
    y = []

    for i, row in enumerate(sheet.rows):
        try:
            val = float(col.getValue(row))
        except (ValueError, TypeError):
            continue

        if key_cols:
            raw_key = tuple(kc.getValue(row) for kc in key_cols)
            key = raw_key[0] if len(raw_key) == 1 else str(raw_key)
        else:
            key = i

        x.append(str(key))
        y.append(val)

    xlabel = key_cols[0].name if key_cols else ""

    with tempfile.NamedTemporaryFile(mode="w", delete=False, suffix=".json") as tmpfile:
        json.dump(
            {
                "x": x,
                "y": y,
                "xlabel": xlabel,
                "ylabel": "Value",
                "title": col.name,
                "window": getattr(sheet, "name", "Plot"),
            },
            tmpfile,
        )
        tmpfile_path = tmpfile.name

    with tempfile.NamedTemporaryFile(mode="w", delete=False, suffix=".py") as pyfile:
        pyfile.write(
            f"""
import json
import matplotlib.pyplot as plt
from matplotlib.widgets import RadioButtons

with open({repr(tmpfile_path)}, 'r') as f:
    data = json.load(f)

x = data['x']
y = data['y']

fig, ax = plt.subplots()
plt.subplots_adjust(bottom=0.25)

[line_plot] = ax.plot(x, y, visible=True)
scatter_plot = ax.scatter(x, y, color='red', visible=False)
stem_container = ax.stem(x, y, linefmt='gray', markerfmt='ko', basefmt=' ')
for part in stem_container:
    try:
        part.set_visible(False)
    except AttributeError:
        pass

# Horizontal layout
radio_ax = plt.axes([0.2, 0.05, 0.6, 0.05])  # wider, shorter
radio = RadioButtons(radio_ax, ['Line', 'Scatter', 'Stem'], active=0)

# Smaller font for compact horizontal layout
for label in radio.labels:
    label.set_fontsize(8)

def update(style):
    line_plot.set_visible(style == 'Line')
    scatter_plot.set_visible(style == 'Scatter')
    for part in stem_container:
        try:
            part.set_visible(style == 'Stem')
        except AttributeError:
            pass
    plt.draw()

radio.on_clicked(update)

ax.set_title(data['title'])
ax.set_xlabel(data['xlabel'])
ax.set_ylabel(data['ylabel'])
ax.grid(True)
fig.canvas.manager.set_window_title(data['window'])
fig.autofmt_xdate()
plt.show()
"""
        )
        pyfile_path = pyfile.name

    subprocess.Popen(["python3", pyfile_path])
    vd.status(f"Plotted {len(y)} values from column: {col.name}")


vd.addCommand(
    None, "plot_column", "plot_column(sheet)", "Plot column with style selector"
)
vd.bindkey("g;", "plot_column")
