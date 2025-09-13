import json
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

        # Determine x-axis key
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

    subprocess.Popen(
        [
            "python3",
            "-c",
            f"""
import json
import matplotlib.pyplot as plt

with open("{tmpfile_path}") as f:
    data = json.load(f)

fig = plt.figure()
plt.plot(data['x'], data['y'], label=data['title'])

plt.xlabel(data['xlabel'])
plt.ylabel(data['ylabel'])
plt.title(data['title'])
plt.grid(True)
plt.legend()
fig.autofmt_xdate()
fig.canvas.manager.set_window_title(data['window'])
plt.tight_layout()
plt.show()
""",
        ]
    )

    vd.status(f"Plotted {len(y)} values from column: {col.name}")


vd.addCommand(None, "plot_column", "plot_column(sheet)", "Plot column")
vd.bindkey("g;", "plot_column")
