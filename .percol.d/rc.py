# config file for percol
from percol.finder import FinderMultiQueryRegex, FinderMultiQueryString

percol.import_keymap({
    "C-a" : lambda percol: percol.command.toggle_mark_all(),
    "C-r" : lambda percol: percol.command.toggle_finder(FinderMultiQueryRegex),
    "C-i" : lambda percol: percol.command.toggle_case_sensitive(),
})
