# Simulate the "old" zsh-behavior because some of the default-bindings
# wont work with my dwm-setup. "fish_key_reader" is used to explain how you
# would bind a certain key sequence.
#
# Alt+S = sudo
# Alt+ArrowUp = insert last word
#
# Execute auto-suggestion with ctrl-space or accept it with ctrl-p
  bind ctrl-space accept-autosuggestion execute
  bind ctrl-p accept-autosuggestion
# Accecpt auto-suggestion with ctrl-p (i know.. ctrl-e would work too, but..)
  bind ctrl-e end-of-line
# Clear screen with "O" because "l" is reserved for vim-tmux-navigator
  bind ctrl-o clear-screen
# runs "tv git-log" in $PWD
  bind  ctrl-f12 'commandline -i "tv git-log"' execute
# shows the manual page for the current command, if one exists
  bind ctrl-k __fish_man_page
# add "sudo" to the beginning of the line
  bind ctrl-n 'for cmd in sudo doas please; if command -q $cmd; fish_commandline_prepend $cmd; break; end; end'
# close to insert-last-word
  bind ctrl-insert history-token-search-backward
# alt+\ == fzffindedit
  bind alt-\\ 'fzffindedit'
