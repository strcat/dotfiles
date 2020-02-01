# $Id: .zlogin,v 1.1 2004/06/10 09:59:46 dope Exp dope $
#
# .zlogin is sourced in login shells.  It should contain commands that
# should be executed only in login shells.  It should be used to run a
# series of external commands (fortune, msgs, etc).
#
# Check incoming ftp files.
if [[ $(uname -n) = hellfire ]]
then
#	INCOMING=/home/ftp/pub/incoming
#	INCOMING=/home/p2p/mldonkey/incoming/files
	INCOMING=/var/lib/mldonkey/incoming/files
	if [[ -d ${INCOMING} ]]
	then
		pushd ${INCOMING}
		newfiles=( )
		[[ -a .timestamp ]] || sudo touch .timestamp
		setopt nullglob
		for file in ^.timestamp
			[[ $file -nt .timestamp ]] && newfiles=( $newfiles $file )
			if [[ -n $newfiles ]]
			then
				echo "New files in ${INCOMING}:"
				print -l "  "$newfiles
				echo ""
			fi
			sudo touch .timestamp
			popd
		fi
	fi

# Check for TODO-entry
if [[ -e ~/TODO ]] && [[ "$TERM" != "screen" ]]
then
	echo "Note: New TODO - entry!"
	echo
	cat ~/TODO
	echo
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Execute code in the background to not affect the current session
(
    # <https://github.com/zimfw/zimfw/blob/master/login_init.zsh>
    setopt LOCAL_OPTIONS EXTENDED_GLOB
    autoload -U zrecompile
    local ZSHCONFIG=~/.zsh-config

    # Compile zcompdump, if modified, to increase startup speed.
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zrecompile -pq "$zcompdump"
    fi
    # zcompile .zshrc
    zrecompile -pq ${ZDOTDIR:-${HOME}}/.zshrc
    zrecompile -pq ${ZDOTDIR:-${HOME}}/.zprofile
    zrecompile -pq ${ZDOTDIR:-${HOME}}/.zshenv
    # recompile all zsh or sh
    for f in $ZSHCONFIG/**/*.*sh
    do
        zrecompile -pq $f
    done
) &!

# Execute code only if STDERR is bound to a TTY.
[[ -o INTERACTIVE && -t 2 ]] && {

  # Print a random, hopefully interesting, adage.
  if (( $+commands[fortune] )); then
    fortune -s
    print
  fi

} >&2
