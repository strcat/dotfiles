# $Id: .zshrc,v 1.1 2007/10/27 19:05:57 dope Exp $
#
# README!
#
# Filename       : ~/.zshrc
# Purpose        : setup file for the shell 'zsh'
# Author         : Christian Schneider <strcat@gmx.net>
# Homepage       : http://www.strcat.de/zsh/
#
# Structure of this file:
#  Lines starting with '#' are comments.
#
# Take a quick (haha) look on zshbuiltins(1), zshcompwid(1),
# zshcompsys(1), zshcompctl(1), zshexpn(1), zshmisc(1), zshmodules(1),
# zshoptions(1), zshparam(1), zshzle(1) or - for hardliner -
# zshall(1).
#  ,----[ Overview (Zsh 4.2.6) ]
#  | [dope@painless:~ :) ]% man -k zsh
#  | zsh                  (1)  - the Z shell (384 lines)
#  | zshall               (1)  - the Z shell meta-man page (19841 lines)
#  | zshbuiltins          (1)  - zsh built-in commands (1756 lines)
#  | zshcompctl           (1)  - zsh programmable completion (593 lines)
#  | zshcompsys           (1)  - zsh completion system (4095 lines)
#  | zshcompwid           (1)  - zsh completion widgets (1026 lines)
#  | zshcontrib           (1)  - user contributions to zsh (1478 lines)
#  | zshexpn              (1)  - zsh expansion and substitution (1613 lines)
#  | zshmisc              (1)  - everything and then some (1474 lines)
#  | zshmodules           (1)  - zsh loadable modules (2443 lines)
#  | zshoptions           (1)  - zsh options (1077 lines)
#  | zshparam             (1)  - zsh parameters (1007 lines)
#  | zshtcpsys            (1)  - zsh tcp system (720 lines)
#  | zshzftpsys           (1)  - zftp function front-end (614 lines)
#  | zshzle               (1)  - zsh command line editor (1575 lines)
#  | [dope@painless:~ :) ]%
#  `----
#
# Zsh start up sequence:
#  1) /etc/zshenv   -> Always run for every zsh.   (login + interactive + other)
#  2)   ~/.zshenv   -> Usually run for every zsh.  (login + interactive + other)
#  3) /etc/zprofile -> Run for login shells.       (login)
#  4)   ~/.zprofile -> Run for login shells.       (login)
#  5) /etc/zshrc    -> Run for interactive shells. (login + interactive)
#  6)   ~/.zshrc    -> Run for interactive shells. (login + interactive)
#  7) /etc/zlogin   -> Run for login shells.       (login)
#  8)   ~/.zlogin   -> Run for login shells.       (login)
#
# Last modified: [ 2019-12-04 18:12:06 ]
#
#
# THIS FILE IS NOT INTENDED TO BE USED AS /etc/zshrc, NOR WITHOUT
# EDITING!
#
# This file is based on ideas of:
#  Michael Prokop: <http://www.michael-prokop.at/computer/config/.zshrc>
#  Marijan Peh...: <http://free-po.hinet.hr/MarijanPeh/files/zshrc>
#  Adam Spiers...: <http://adamspiers.org/computing/shells/>
#
# Tested and used under {Net,Open}BSD, Slackware, Gentoo, Debian and LFS
# with Zsh 4.0.7, 4.0.9, 4.1.1, 4.2.0. 4.2.1, 4.2.4, 4.2.5 and 4.2.6.
#
# Login shell? If you want to know, you can type the following which will
# do nothing it's a login shell or warn you if not.
#--------------------------------------------------
# if [[ ! -o login ]]; then
#         print "Warning: It is *not* a login-Shell\!"
# fi
#--------------------------------------------------

# -f true if file exists and is a regular file. See
#  | man zshmisc | less -p "^CONDITIONAL EXPRESSIONS"
# for details.

# Test and then source exported variables.
if [ -f ~/.zsh/zshexports ]; then
    source ~/.zsh/zshexports
else
    print "Note: ~/.zsh/zshexports is unavailable."
fi

# Test and then source some options
if [ -f ~/.zsh/zshoptions ]; then
    source ~/.zsh/zshoptions
else
    print "Note: ~/.zsh/zshoptions is unavailable."
fi


# Test and then source alias definitions.
if [ -f ~/.zsh/zshaliases ]; then
    source ~/.zsh/zshaliases
else
    print "Note: ~/.zsh/zshaliases is unavailable."
fi

# Test and then source the functions.
if [ -f ~/.zsh/zshfunctions ]; then
    source ~/.zsh/zshfunctions
else
    print "Note: ~/.zsh/zshfunctions is unavailable."
fi

# Test and then source the lineeditor
if [ -f ~/.zsh/zshzle ]; then
    source ~/.zsh/zshzle
else
    print "Note: ~/.zsh/zshzle is unavailable."
fi

# Test and then source the keybindings
if [ -f ~/.zsh/zshbindings ]; then
    source ~/.zsh/zshbindings
else
    print "Note: ~/.zsh/zshbindings is not available."
fi

# Test and then source the completionsystem
if [ -f ~/.zsh/zshcompctl ]; then
    source ~/.zsh/zshcompctl
else
    print "Note: ~/.zsh/zshcompctl is unavailable."
fi

# Test and then source the zstyles
if [ -f ~/.zsh/zshstyle ]; then
    source ~/.zsh/zshstyle
    # source /home/dope/.zsh/zshstyle
else
    print "Note: ~/.zsh/zshstyle is unavailable."
fi

# Test and then source the wretched rest
if [ -f ~/.zsh/zshmisc ]; then
    source ~/.zsh/zshmisc
else
    print "Note: ~/.zsh/zshmisc is unavailable."
fi

# http://www.unixreview.com/documents/s=9513/ur0501a/ur0501a.htm
if [ -f ~/.zsh/zshkeep ]; then
    source ~/.zsh/zshkeep
else
    print "Note: ~/.zsh/zshkeep is unavailable."
fi

# https://github.com/junegunn/fzf
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh && source ~/.zsh/zshfzf
else
    rm -rf ~/.fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# https://ohmyposh.dev/docs/installation/prompt
if (($+commands[oh-my-posh])); then
    eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/pure.json)"
fi

# zoxide
if (($+commands[zoxide])); then
    eval "$(zoxide init --cmd cd zsh)"
fi

# Fish-like autosuggestions for zsh
if [ -f ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# https://github.com/alexpasmantier/television/
if (($+commands[tv])); then
        eval "$(tv init zsh)"
fi

# Atuin
if (($+commands[atuin])); then
    eval "$(atuin init zsh --disable-up-arrow)"
fi

# https://github.com/iffse/pay-respects
if (($+commands[pay-respects])); then
        eval "$(pay-respects zsh)"
fi
