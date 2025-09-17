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
                "ylabel": "",  # no y-label
                "title": col.name,
                "window": getattr(sheet, "name", "Plot"),
            },
            tmpfile,
        )
        tmpfile_path = tmpfile.name

    with tempfile.NamedTemporaryFile(mode="w", delete=False, suffix=".py") as pyfile:
        pyfile.write(
            """
import json
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from matplotlib.widgets import Button

with open("{path}", 'r') as f:
    data = json.load(f)

x = data['x']
y = data['y']

fig = plt.figure(figsize=(6, 4))
gs = gridspec.GridSpec(2, 1, height_ratios=[10, 1])
ax = fig.add_subplot(gs[0])
btn_area = fig.add_subplot(gs[1])
btn_area.axis("off")

[line_plot] = ax.plot(x, y, visible=True)
scatter_plot = ax.scatter(x, y, color='red', visible=False)
stem_container = ax.stem(x, y, linefmt='gray', markerfmt='ko', basefmt=' ')
for part in stem_container:
    try:
        part.set_visible(False)
    except AttributeError:
        pass

btns = {{}}
btn_width = 0.2
lefts = [0.2, 0.4, 0.6]
labels = ["Line", "Scatter", "Stem"]

for left, label in zip(lefts, labels):
    ax_btn = fig.add_axes([left, 0.05, btn_width, 0.08])
    btns[label] = Button(ax_btn, label)
    for text in btns[label].ax.texts:
        text.set_fontsize(8)

def set_style(style):
    line_plot.set_visible(style == "Line")
    scatter_plot.set_visible(style == "Scatter")
    for part in stem_container:
        try:
            part.set_visible(style == "Stem")
        except AttributeError:
            pass
    plt.draw()

btns["Line"].on_clicked(lambda event: set_style("Line"))
btns["Scatter"].on_clicked(lambda event: set_style("Scatter"))
btns["Stem"].on_clicked(lambda event: set_style("Stem"))

ax.set_title(data['title'])
ax.set_xlabel(data['xlabel'])
ax.set_ylabel("")  # no y-label
ax.grid(True)
ax.set_xlim(auto=True)
fig.tight_layout()
fig.canvas.manager.set_window_title(data['window'])
fig.autofmt_xdate()
plt.show()
""".format(
                path=tmpfile_path
            )
        )

        pyfile_path = pyfile.name

    subprocess.Popen(["python3", pyfile_path])
    vd.status(f"Plotted {len(y)} values from column: {col.name}")


vd.addCommand(
    None, "plot_column", "plot_column(sheet)", "Plot column with style buttons"
)
vd.bindkey("g;", "plot_column")
