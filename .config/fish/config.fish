# Problem: Scripts are slow because my configuration in this file is slow.
# Solution: Skip the configuration if not running interactively.
#
# Unlike files like `~/.bashrc` (which runs only for interactive shells)
# shells, `config.fish` is run for *every* fish shell, including
# non-interactive shells. This was surprising to me.
#
# By skipping it, I speed up things like:
#
# * scripts that run with `#!/usr/bin/env fish`
# * fzf, surprisingly: $FZF_DEFAULT_COMMAND is run with $SHELL, approximately
#   equivalent to doing `fish -c $FZF_DEFAULT_COMMAND`
if status is-interactive
        # echo ""
        # fortune -a | cowsay
        # echo ""
end

# Don't print a greeting when a new interactive fish shell is started
  set -U fish_greeting
# Zoxide
  if command -q zoxide
          zoxide init --cmd cd fish | source
  end
# oh-my-posh
  if command -q oh-my-posh
          oh-my-posh init fish --config ~/.config/ohmyposh/ohmyposh.toml | source
  end
# https://alexpasmantier.github.io/television/
  if command -q tv
          tv init fish | source
  end
# do not use slow default handle when not the command we typed not found
  function fish_command_not_found
          __fish_default_command_not_found_handler $argv
  end

# format the pager
  set -g fish_pager_color_completion normal
  set -g fish_pager_color_description 555 yellow
  set -g fish_pager_color_prefix cyan
  set -g fish_pager_color_progress cyan
# Set the path 
#   set -x PATH $PATH \
#       ~/.local/bin \
#       ~/.cargo/bin \
#       ~/.rvm/bin \
#       ~/.yarn/bin \
#       ~/bin
# faster way
  fish_add_path -aP ~/go/bin
  fish_add_path -aP ~/.local/bin
  fish_add_path -aP ~/.cargo/bin
  fish_add_path -aP ~/.rvm/bin
  fish_add_path -aP ~/bin

# # dircolors
  if test -f ~/.dircolors
          eval (dircolors -c ~/.dircolors)
  end
# OS-specific customizations .. not yet..
# uname is fucking slow.. 
# switch (uname)
#         case Linux
#                 source ~/.config/fish/conf.d/linux.fish
#         case OpenBSD
#                 source ~/.config/fish/conf.d/openbsd.fish
# end
