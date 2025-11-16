set --export EDITOR nvim
set --export SUDO_EDITOR vim
set --export VISUAL nvim
set --export MANPAGER nvim +Man!
if command -q bat
        set --export PAGER bat
        alias less=bat
end
set --export GOPATH ~/go
# if command --search --quiet go
# 	set --export PATH "$GOPATH/bin:$PATH"
# end
#
# Use builtin command `set` instead of `fish_add_path` because it is slow
# set --export PATH "$HOME/.local/bin:$PATH"
