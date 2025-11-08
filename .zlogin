# $Id: .zlogin,v 1.1 2004/06/10 09:59:46 dope Exp dope $
#
# .zlogin is sourced in login shells.  It should contain commands that
# should be executed only in login shells.  It should be used to run a
# series of external commands (fortune, msgs, etc).
#
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Execute code only if STDERR is bound to a TTY.
[[ -o INTERACTIVE && -t 2 ]] && {

  # Print a random, hopefully interesting, adage.
  if (( $+commands[fortune] )); then
    fortune -s
    print
  fi

} >&2
