import re
import vim

buffer = vim.current.buffer
(lstart, col1) = buffer.mark('<')
(lend, col2) = buffer.mark('>')
lines = vim.eval('getline({}, {})'.format(lstart, lend))
m = re.match(r'(\d+)\.', lines[0])
start_num = int(m.group(1))

for (i, line) in enumerate(lines):
    line_num = lstart + i
    new_num = start_num + i
    vim.command(rf"{line_num}s/\d\+\./{new_num}\./")

vim.command(":nohlsearch")
