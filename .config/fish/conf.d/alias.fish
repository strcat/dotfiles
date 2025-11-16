# aliases, abbrs and simple functions
#
# aliases makes fish slow.. very slow.. so keep is small and simple
# To check first use 
#  if type --query foo ..
# or
#  command -v foo &>/dev/null && alias foo="bar"
# or
#  command -v foo &>/dev/null && alias foo="bar" || alias foo="foobar"
# or - talking to myself "RTFM you idiot"
#  command --quiet foo ...
#
# https://github.com/Genivia/ugrep
if type --query ug
  alias uq='ug -Q'                  # short & quick query UI (interactive, uses .ugrep config)
  alias ux='ug -UX'                 # short & quick binary pattern search (uses .ugrep config)
  alias uz='ug -z'                  # short & quick compressed files and archives search (uses .ugrep config)
  alias ugit='ug -R --ignore-files' # works like git-grep & define your preferences in .ugrep config
  alias grep='ugrep -G'             # search with basic regular expressions (BRE)
  alias egrep='ugrep -E'            # search with extended regular expressions (ERE)
  alias fgrep='ugrep -F'            # find string(s)
  alias pgrep='ugrep -P'            # search with Perl regular expressions
  alias xgrep='ugrep -W'            # search (ERE) and output text or hex for binary
  alias zgrep='ugrep -zG'           # search compressed files and archives with BRE
  alias zegrep='ugrep -zE'          # search compressed files and archives with ERE
  alias zfgrep='ugrep -zF'          # find string(s) in compressed files and/or archives
  alias zpgrep='ugrep -zP'          # search compressed files and archives with Perl regular expressions
  alias zxgrep='ugrep -zW'          # search (ERE) compressed files/archives and output text or hex for binary
end

if type --query dfc
  alias df='dfc -sdlmt ext4,ext2,brtfs'
end

 # daily stuff
alias vim=nvim
alias trl='transmission-remote -l'
# alias trrm='transmission-remote -t $argv[0] -r'
alias cp="cp --verbose --backup=numbered"
alias mv="mv --verbose --backup=numbered"
alias mkdir="mkdir -p"
alias su='su -'

if type --query grc
  alias grc='grc --colour=auto'
  alias ps='grc ps'
  alias ping='grc ping'
  alias last='grc last'
  alias netstat='grc netstat'
  alias traceroute='grc traceroute'
  alias diff='grc diff'
  alias gcc='grc gcc'
  alias configure='grc configure'
  alias cvs='grc cvs'
  alias gcc='grc gcc'
  alias configure='grc ./configure'
  alias cat="grc cat"
  alias ip="grc ip"
  alias nmap="grc nmap"
  alias gcc="grc gcc"
  alias cc="grc cc"
  alias make="grc make"
  alias gmake="grc gmake"
  alias g++="grc g++"
  alias c++="grc c++"
end

# Some youtube-dl related aliases
if type --query yt-dlp
  alias yta-aac="yt-dlp --extract-audio --audio-format aac "
  alias yta-best="yt-dlp --extract-audio --audio-format best "
  alias yta-flac="yt-dlp --extract-audio --audio-format flac "
  alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
  alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
  alias yta-opus="yt-dlp --extract-audio --audio-format opus "
  alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
  alias yta-wav="yt-dlp --extract-audio --audio-format wav "
  alias ytv-best="yt-dlp -f bestvideo+bestaudio "
  alias xdl="yt-dlp -o '~/Downloads/XXX/%(title)s.%(ext)s'"
end

# yeah.. i'm edit them often.. very often
  alias Ef='$EDITOR ~/.config/fish/config.fish'
  alias Em='$EDITOR ~/.muttrc'
  alias En='$EDITOR ~/.config/nvim/init.lua'
  alias Es='$EDITOR ~/.slrnrc'
  alias Esig="$EDITOR ~/.sigs/own-stuff"
  alias Et='$EDITOR ~/.tmux.conf'
  alias Ev='$EDITOR ~/.vimrc'
  alias Ez='$EDITOR ~/.zshrc'
# Use colors, do not check for new groups, specific my killfile an use
# spool (needed for slrnpull)
  alias news='slrn -C -n --kill-log ~/.slang/KILL --spool -f ~/.jnewsrc'
  alias gnews='slrnpull -d ~/nslrn/slrnpull --logfile ~/nslrn/slrnpull/log -h news.solani.org'
  # alias gnews='slrnpull -d ~/nslrn/slrnpull --logfile ~/nslrn/slrnpull/log -h news.uni-stuttgart.de'

# call mailfilter and start getmail after a positive return value
# <http://mailfilter.sourceforge.net/> && <http://www.qcc.ca/~charlesc/software/getmail-3.0/>
  alias gmail='getmail -v --rcfile ~/.getmail/getmailrc-gmail \
               --rcfile ~/.getmail/getmailrc-schneider \
               --rcfile ~/.getmail/getmailrc-strcat \
               --rcfile ~/.getmail/getmailrc-blog \
               --rcfile ~/.getmail/getmailrc-web \
               --rcfile ~/.getmail/getmailrc-eigenes \
               --rcfile ~/.getmail/getmailrc-404'
# the two above together..
  alias gall="gmail ; gnews"

# start mutt/vim/zsh/jed without any setup
  alias null-mutt='mutt -n -f /dev/null -F /dev/null'
  alias null-zsh='zsh -f'
  alias null-vim='$EDITOR --clean' # starts with defaults in non-compatible mode
  alias null-irssi='irssi --config=/dev/null'

# https://github.com/eza-community/eza
if type --query exa
    alias ls='eza --color=always --group-directories-first --icons=always' # my preferred listing
    alias l='eza -al --color=always --group-directories-first --icons=always' # my preferred listing
    alias la='eza -a --color=always --group-directories-first --icons=always'  # all files and dirs
    alias ll='eza -l --color=always --group-directories-first --icons=always'  # long format
    alias lt='eza -aT --color=always --group-directories-first --icons=always' # tree listing
    alias lsa='eza -a | egrep "^\."'
    alias lsd='eza -D' #  list only directories
    alias lad='eza -Da' # only directories including dots
    alias lsg='eza --long --git' # git status
    # $argv[2] == "-n count"
    alias lsnew='eza -lsnew | tail $argv[2]'
    alias lsold='eza -lsold | tail $argv[2]'
    alias lsbig='eza -lssize | tail $argv[2]'
    alias lssmall='eza -lssize | head $argv[2]'
end

# OK.. now the abbr's
# --add = creates a new abbreviation
# --position anywhere = the abbreviation will only expand when it is positioned as a command, 
#                       not as an argument to another command. With --position anywhere
#                       the abbreviation may expand anywhere in the command line. The default is
# command,.
  abbr --add dotdot --regex '^\.\.+$' --function multicd
  abbr --add --position anywhere Ip '| $PAGER'
  abbr --add --position anywhere Iw '| wc'
  abbr --add --position anywhere Is '| sort'
  abbr --add --position anywhere Ih '| head'
  abbr --add --position anywhere Ig '| grep'
  abbr --add --position anywhere It '| tail'
  abbr --add --position anywhere A  '~/scripts/Asciidoc'			# selfwritten documentation in asciidoc-format
  abbr --add --position anywhere B  '~/homepage/blog/ohnetags/content/'
  abbr --add --position anywhere C  '~/.config/'					    # https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
  abbr --add --position anywhere D  '~/Downloads/'					  # there are my downloads
  abbr --add --position anywhere F  '~/.config/fish/'         # Fishshell
  abbr --add --position anywhere FF ' /mnt/MP3/'              # MP3s
  abbr --add --position anywhere G  '~/.getmail'					    # Configfiles for getmail
  abbr --add --position anywhere HG '~/download/Source/Repos'	# HG/GIT/SVN/..- Repos
  abbr --add --position anywhere I  '~/.irssi/'					      # Files for Irssi
  abbr --add --position anywhere L  '~/.slang/'					      # Files for Slrn
  abbr --add --position anywhere M  '~/.mutt/'					      # Files for Mutt
  abbr --add --position anywhere MF '~/.mailfilter'			      # Configfiles for mailfilter
  abbr --add --position anywhere NN '~/.config/nvim/'         # Files for nvim
  abbr --add --position anywhere P  '~/homepage/'					    # My personal webpage
  abbr --add --position anywhere S  '~/scripts/'					    # (Un)tested local hacks
  abbr --add --position anywhere SC ' /mnt/Commedy'					  # Questions? Any?
  abbr --add --position anywhere SM ' /mnt/Movies'				    # yep
  abbr --add --position anywhere SO '~/download/Sources'			# Mutt, Slrn, Vim, ..
  abbr --add --position anywhere SS ' /mnt/Serien/'					  # name it..
  abbr --add --position anywhere SX ' /mnt/XXX'					      # what?!
  abbr --add --position anywhere T  '~/download/Torrents'			# Bittorrent is evil.. isn't it?
  abbr --add --position anywhere V  '~/Videos/'					      # Downloaded video-files
  abbr --add --position anywhere VL ' /var/log'					      # often visited ;)
  abbr --add --position anywhere Z  '~/.zsh/'					        # "setupfiles" for ZSH
  abbr --add --position anywhere _S '~/.sigs/'					      # My signature collection
