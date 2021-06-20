# https://docs.julialang.org/en/v1/stdlib/REPL/#Key-bindings
#
import REPL
import REPL.LineEdit

const mykeys = Dict{Any,Any}(
     # Up Arrow
     "\\C-k" => (s,o...)->(LineEdit.edit_move_up(s) || LineEdit.history_prev(s, LineEdit.mode(s).hist)),
     # Down Arrow
     "\\C-j" => (s,o...)->(LineEdit.edit_move_down(s) || LineEdit.history_next(s, LineEdit.mode(s).hist))
    )

function customize_keys(repl)
    repl.interface = REPL.setup_interface(repl; extra_repl_keymap = mykeys)
end

atreplinit(customize_keys)
