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
