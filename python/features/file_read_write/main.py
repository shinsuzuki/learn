from pathlib import Path


def file_read_lines(path, encoding="utf-8"):
    return Path(path).read_text(encoding).splitlines()


def file_write_lines(path, lines, encoding="utf-8"):
    Path(path).write_text("\n".join(lines), encoding)


# ファイル読込
# lines = file_read_lines("sample.txt", "utf-8-sig")
lines = file_read_lines("sample-no-bom.txt", "utf-8")
for line in lines:
    print("line:" + line)

# output lines
output_lines = []
for line in lines:
    output_lines.append("head:" + line + ":tail")

# ファイル書込
file_write_lines("output.txt", output_lines)
