" $Id: .vimrc,v 1.1 2002/09/27 02:13:02 dope Exp dope $
"
" Informations 
"    File: $HOME/.vimrc
"  Author: Christian Schneider <strcat(at)gmx.net>
" Purpose: setup file for the editor "vim"
"     URL: <http://strcat.de/vimrc> || <http://www.vim.org/>
"    Size: This file is about 50K in size and has 1,600+ lines.
" Notices: This file is based on Sven Guckes http://www.guckes.net/vimrc.forall
"    Note: If your read this then please send me an email! I welcome all
"          feedback on this file - especially with new ideas such as abbreviations
"          and mappings.
"     Tip: Open this file with 'vim -c 'set foldmethod=marker' this-file' or -
"          if Vim already runnig - type ':set foldmethod=marker' for a /better/
"          oversight ;)
" Version: This setup file uses a lot of features of Vim-6. If you are still
"          using Vim-5 (or an even older version) then you should upgrade - it
"          is really worth the effort!
" Warning: Download instead view+save! So if you are viewing this file with a
"          web browser then do *not* "save" this file because the contents 
"          have already been interpreted - including the control characters. 
"          Instead, you must *download* this file to preserve them.
"
" Structure of this file:
"       First up is the settings that I use. They are ordered alphabetically
"       to make it easier to access a specific item. Basically a simple way
"       to sort data :-) These are not all the possible settings, but the ones
"       that I have found relevant to control. (:h options)
"
"       There are three kinds of things which are defined in this file:
"       Mappings ("map"), settings ("set"), and abbreviations ("ab").
"               - Settings affect the behaviour of commands.
"               - Mappings maps a key sequence to a command.
"               - Abbreviations define words which are replaced right 
"                 *after* they are typed in.
"       Here is an overview of map commands and in which mode they work:
"         ,----
"         | :map               Normal, Visual and Operator-pending
"         | :vmap              Visual
"         | :nmap              Normal
"         | :omap              Operator-pending
"         | :map!              Insert and Command-line
"         | :imap              Insert
"         | :cmap              Command-line
"         `----
"       Lines starting with an inverted comma (") are comments. Furthermore,
"       's within the line starts a comment unless it is preceeded by a backslash (\").
"       VIM allows to give special characters by writing them in a special notation.
"       The notation encloses descriptive words in angle brackets (<>).
"       Read all about it with ":help <>".
"          The characters you will most often are:
"               - <C-M> for control-m
"               - <C-V> for control-v which quotes the following character
"               - <ESC> for the escape character.
"               - <Fn>  for F1, F2, ..
"               - <C-n> for control-n (i. e. strg-a, strg-k, ..)
"       $VIMRUNTIME == /usr/local/share/vim/vim61f
"
" setting description:
" [global] ... global setting
" [buffer] ... local to a buffer
" [window] ... settings for a window
" [glo-lo] ... global or local (buffer) setting. :setlocal for local value
" 
" Some mappings and options are commented out. Remove the comment to enable them.
" 
" All control characters have been replaced to use the angle notation
" so you should be able to read this filw without problems.
" (OK, I left some tabs [control-i] in the file. ;-)
"
" ~/.vim/
"     +---> colors/     # color scheme files
"     +---> doc/        # documentations
"     +---> forms/      # submittals
"     +---> ftplugin/   # filetype plugins
"     +---> macros/     # macros common to both versions of VIM
"     +---> plugin/     # plugins common to both versions of VIM
"     +---> syntax/     # syntax files
"     +---> templates/  # Own template files
"
" To learn VIM:
"   -> run "vimtutor" from your Unix/Linux-prompt and go through it
"   -> RTFM - read the f****** - ah - FINE manual ;-)
"   -> visit the websites mentioned in this document
"       * <http://www.vim.org/>                    - vim-homepage
"       * <http://www.guckes.net/vim/>             - Sven's Vim Page
"       * <http://hermitte.free.fr/vim/>           - Luc's Hermitte
"       * <http://www.liacs.nl/~jvhemert/vim/>     - Jano's Vim Macro Page
"       * <http://users.erols.com/astronaut/vim/>  - Dr Chip's Vim Page
"       * <http://www.thomer.com/vi/vi.html>       - VI Lover's Homepage
"       * <http://www.rayninfo.co.uk/vimtips.html> - Best of Vim Tips
"       * <news:de.comp.editoren>                  - german newsgroup with topic editors
"       * <news:comp.editors>                      - international newsgroup with topic editors
"   -> Try the documentation »:help your_keyword«
"               WHAT                   PREPEND    EXAMPLE
"               Normal mode commands  (nothing)   :help x
"               Visual mode commands      v_      :help v_u
"               Insert mode commands      i_      :help i_<Esc>
"               command-line commands     :       :help :quit
"               command-line editing      c_      :help c_<Del>
"               Vim command arguments     -       :help -r
"               options                   '       :help 'textwidth'
"
"  To use this setup file, copy it to
"            Linux/Unix:  ~/.vimrc
"                  OS/2:  ~/.vimrc or $VIM/.vimrc (or _vimrc)
"             for Amiga:  s:.vimrc or $VIM/.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc or $VIM/_vimrc
"           for OpenVMS:  sys$login:.vimrc
" 
" There are many options for Vim - over 400:
" »grep -c '{".*P_' src/option.c«
"       Release dates given in format "yymmdd":
"         - VIM-5.4   [990726] 218 options.
"         - VIM-5.7   [000624] 219 options.
"         - VIM-6.0ae [010504] 283 options.
"         - VIM-6.1   [020324] 310 options.
"         - VIM-6.2f  [030323] 322 options.
"         - VIM-6.3   [040607] 314 options.
"         - VIM-7.0   [050120] 333 options.
"         - VIM-8.1   [000000] 411 options.
"
" Powered by OpenBSD 6.3, VIM - Vi IMproved 6.3, RedBull, Dunhill Navy
" Rolls and Metallica.
"
" ,----[ vim --version ]
" | VIM - Vi IMproved 8.1 (2018 May 18, compiled Jul  6 2018 18:48:37)
" | Included patches: 1-155
" | Compiled by Christian Schneider <strcat1974@gmail.com>
" | Huge version without GUI.  Features included (+) or not (-):
" | +acl               +farsi             +mouse_sgr         -tag_any_white
" | +arabic            +file_in_path      -mouse_sysmouse    -tcl
" | +autocmd           +find_in_path      +mouse_urxvt       +termguicolors
" | -autoservername    +float             +mouse_xterm       +terminal
" | -balloon_eval      +folding           +multi_byte        +terminfo
" | +balloon_eval_term -footer            +multi_lang        +termresponse
" | -browse            +fork()            -mzscheme          +textobjects
" | ++builtin_terms    +gettext           +netbeans_intg     +timers
" | +byte_offset       -hangul_input      +num64             +title
" | +channel           +iconv             +packages          -toolbar
" | +cindent           +insert_expand     +path_extra        +user_commands
" | -clientserver      +job               +perl              +vartabs
" | -clipboard         +jumplist          +persistent_undo   +vertsplit
" | +cmdline_compl     +keymap            +postscript        +virtualedit
" | +cmdline_hist      +lambda            +printer           +visual
" | +cmdline_info      +langmap           +profile           +visualextra
" | +comments          +libcall           +python/dyn        +viminfo
" | +conceal           +linebreak         +python3/dyn       +vreplace
" | +cryptv            +lispindent        +quickfix          +wildignore
" | +cscope            +listcmds          +reltime           +wildmenu
" | +cursorbind        +localmap          +rightleft         +windows
" | +cursorshape       +lua               +ruby              +writebackup
" | +dialog_con        +menu              +scrollbind        -X11
" | +diff              +mksession         +signs             -xfontset
" | +digraphs          +modify_fname      +smartindent       -xim
" | -dnd               +mouse             +startuptime       -xpm
" | -ebcdic            -mouseshape        +statusline        -xsmp
" | +emacs_tags        +mouse_dec         -sun_workshop      -xterm_clipboard
" | +eval              -mouse_gpm         +syntax            -xterm_save
" | +ex_extra          -mouse_jsbterm     +tag_binary
" | +extra_search      +mouse_netterm     +tag_old_static
" |    system vimrc file: "$VIM/vimrc"
" |      user vimrc file: "$HOME/.vimrc"
" |  2nd user vimrc file: "~/.vim/vimrc"
" |       user exrc file: "$HOME/.exrc"
" |        defaults file: "$VIMRUNTIME/defaults.vim"
" |   fall-back for $VIM: "/home/dope/dev-bin/share/vim"
" | Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H     -g -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
" | Linking: gcc   -L. -Wl,-z,relro -Wl,-z,now -fstack-protector -rdynamic
" | -Wl,-export-dynamic -Wl,-E   -L/usr/local/lib -Wl,--as-needed -o vim
" | -lm -ltinfo -lnsl    -ldl  -L/usr/lib -llua5.2 -Wl,-E
" | -fstack-protector-strong -L/usr/local/lib
" | -L/usr/lib/x86_64-linux-gnu/perl/5.24/CORE -lperl -ldl -lm -lpthread
" | -lcrypt    -lruby-2.3 -lpthread -lgmp -ldl -lcrypt -lm
" `----
"
"  It was also compiled with:
"   | ./configure --without-x --with-compiledby='Christan Schneider <strcat@gmx.net>' \
"   |             --with-features=huge
"
"
"function! SourceIfExists(file)
	"if filereadable(expand(a:file))
		"exe 'source' a:file
	"endif
"endfunction
"call SourceIfExists("~/.vim/vimoptions")

" Options initiating with »a« 

" [buffer] |'autoindent'| off as I usually do not write code 
set ai

" [global] |'autowrite'| on saves a lot of trouble
set aw

" [glo-lo] |'autoread'| autom. read file when changed outside of Vim
set ar

" [global] |'backspace'| how backspace works at start of line
set bs=2

" [global] |'backup'| Make a backup (i. e. 'file~') and save it.
set bk

" [global] |'backupdir'| write backup into special directory if it exists, otherwise create 
"          it.
if has("unix")
        if !isdirectory(expand("~/tmp/."))
                !mkdir -p ~/tmp/
        endif
endif
set bdir=~/tmp

" [global] |'backupskip'| no backup for files that match these patterns
set bsk=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

" [buffer] |'comments'| comments default: sr:/*,mb:*,el:*/,://,b:#,:%,:XCOMM,n:>,fb:-
" set comments=b:#,:%,fb:-,n:>,n:)
"                       b:\" repeats " , requires blank
"   Strings that        b:#  repeats # , requires blank after #.
"   start a             :%   repeats %
"   comment line        fb:- first line only , requires blank
"                       fbn:* first line only , requires blank, nests
"                       n:>  repeats > , nesting allowed   eg "> > >"
"                       n:)  repeats ) , nesting allowed   eg ") > )"  
"                                               Note the >     ^^^^^
set com=b:\",b:#,:%,fbn:-,fb:*,n:>,n:),:\[---\ snip,:--\

" [global] |'cpo'|  flags for Vi-compatible behavior
set cpoptions=aABceFsJWy

" [global] |'cp'| compatible to vi? Hey. If i want Vi, i'm *using* Vi and not Vim.
set nocompatible

" [global] |'cmdheight'| Disable the 'Press RETURN...' - Messages
set ch=2

" [global] |'digraph'| required for those umlauts
set dg

" [glo-lo] |'dictionary'| list of file names used for keyword completion
set dict=/usr/share/dict/words

" [global] |'diffopt'| options for using diff mode
set dip=filler,context:4,iwhite

" [global] |'display'| to display as much as possible of the last line in a window instead
"                      of displaying the '@' symbols.
set dy=lastline

" [global] |'edcompatible'| toggle flags of ":substitute" command
" set noed
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1

" [global] |'esckeys'| allows cursor keys within insert mode only on SunOS
if has("unix") && system('uname')=='SunOS'
    set ek
endif

" [global] |'errorfile'| name of the errorfile for the QuickFix mode
set ef=error.err

" [glo-lo] |'errorformat'| description of the lines in the error file
set efm+=%f:%l:\ %m,%Dmake[%*\\d]:\ Entering\ directory\ `%f',%Dmake[%*\\d]:\ Leaving\ directory\ `%f'

" [global] |'errorbells'|  be quiet
set noeb

" [buffer] |'expandtab'| Expand Tabs? Rather not.
set noet
" 

" Options initiating with »f« 
" [window] |'foldmethod'| Folding is evil ;)
if has("folding")
        set fdm=manual
endif

" [global] |'fillchars'| characters to use for displaying special items
" set fcs=vert:\|,fold:-
set fillchars=vert:\ ,fold:\ " 

" [global] |'fileformat'| The Right Way(tm)
set ff=unix

" [buffer] |'formatoptions'| Options for text format
"               - »c«: autowrap coments _with_ leader
"               - »q«: use leader when formatting (gq or mapped Q)
"               - »r«: insert the current comment leader automatically
"               - »t«: use textwidth
"               - »2«: use 2nd line's indentation for rest of paragraph
set fo=cqrtc2
" 

" [glo-lo] |'grepprg'| program to use for ":grep"
" set gp=grep\ -n\ $*\ /dev/null
set grepprg=grep\ -nH\ $*
" 

" Options initiating with »h« 
" [global] |'helpheight'| the mindestheight for ':help'
set hh=20

" [global] |'hid'| dont close changed window
set hidden

" [global] |'hi'| make the history longer
set history=500

" [global] |'hlsearch'| Stop the highlighting for the 'hlsearch' option (simple press <F4> instead).
set nohls
" 

" Options initiating with »i« 
" [global] |'incsearch'| dont highlight searchresults
set is

" [global] |ignorecase'| ignore the case in search patterns? Nope.
"          Note: If you want to ignore case for one specific pattern, you can do this 
"                by prepending the "\c" string.  Using "\C" will make the pattern to 
"                match case.
set noic

" [global] |'icon'| let Vim set the text of the window icon? icon? *rofl*
set noicon

" When started as "evim", evim.vim will already have done these settings.
" Note: If you want to go to Normal mode to be able to type a sequence of
"       commands, use CTRL-L.
if v:progname =~? "evim"
       finish 
endif


" [buffer] |'iskeyword'| enable the search for @, ., _ and -
set isk=@,48-57,_,192-255,-,.,@-@

" Options initiating with »k« 

" [global] |'keywordprg'| program to use for the "K" command
set kp=man

" 

" Options initiating with »l« 
" [global] |'laststatus'| show statusline
set ls=2

" [global] |'lazyredraw'| no screenupdate during macro
set nolz

" [window] |'linebreak'| If on Vim will wrap long lines at a character in 'breakat' rather 
"                        than at the last character that fits on the screen.      
set lbr

" [window] |'list'| show <Tab> and <EOL>
set list

" This tells Vim which characters to show for expanded TABs, trailing whitespace, 
" end-of-lines, ...
" [window] |'listchars'| Strings to use in 'list' mode
:set lcs=tab:>-,trail:-

" Options initiating with »m« 
" [global] |'magic'| Set 'magic' patterns ;)
" Examples:
"  \v       \m       \M       \V         matches ~
"  $        $        $        \$         matches end-of-line
"  .        .        \.       \.         matches any character
"  *        *        \*       \*         any number of the previous atom
"  ()       \(\)     \(\)     \(\)       grouping into an atom
"  |        \|       \|       \|         separating alternatives
"  \a       \a       \a       \a         alphabetic character
"  \\       \\       \\       \\         literal backslash
"  \.       \.       .        .          literal dot
"  \{       {        {        {          literal '{'
"  a        a        a        a          literal 'a'
set magic

" [global] |'makeef'| name of the errorfile for ":make"
set mef="~/tmp/vim##.err"

" [buffer] |'modeline'| disable modeline
set ml

" [buffer] |'matchpairs'| pairs of characters that "%" can match
set mps=(:),[:],{:},<:>
" 

" Options initiating with »n« 
" [buffer] |'nrformats'| number formats recognized for CTRL-A command
set nf=hex

" Options initiating with »o« 

" [global] |'pastetoggle'| exit paste-mode (<F7>)
set pt=<F2>

" [glo-lo] |'path'| The list of directories to search when you specify a file with an edit
"                   command (~/new is my dir with www pages)
set pa=.,,/usr/include,~/new/*/,$VIM/syntax,~/.vim/*

" [global] |'printoptions'| controls the format of :hardcopy output
set popt=paper:letter,number:y,portrait:y

" [global] |'printheader'| format of the header used for :hardcopy
set pheader=%<%f%=Christian\ Schneider\ (strcat@gmx.net)\ %N
" 

" Options initiating with »r« 

" [global] |'report'| always report changes
set report=0

" [global] |'runtimepath'| This is a list of directories which will be searched for runtime files:
set rtp=~/.vim,$VIMRUNTIME
" 

" Options initiating with »s« 
" [global] |'scrolloff'| minimum nr. of lines above and below cursor
  set so=1

" [global] |'suffixes'| ignore this suffixes while ':edit'
set su=.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar,.tgz,.tar,.zip

" [global] |'splitbelow'| splitting a window will put the new window below the current one
set nosb

" [global] |'startofline'| commands listed below move the cursor to the first blank of the line
set nosol

" [global] |'shell'| Execute ':!<command>' with Zsh. I use Zsh, Ksh and Sh. In this
"                    order! No Bash, no Tcsh and no other toys. -l is equivalent to 
"                    --login (See zsh --help for details)
" start the zsh as a login shell:
if has("unix")
        let &sh="zsh \-l"
endif

" [global] |'secure'| trust this current file, but no other
set secure

" [buffer] |'shiftwidth'| eight spaces are one TAB
set sw=8 

" [global] |'shortmess'| list of flags, reduce length of messages
set shm=atIT

" [global] |'shiftround'| round indent to multiple of shiftwidth
set sr

" [global] |'showbreak'| String to put at the start of lines that have been wrapped
set sbr=+

" [global] |'showcmd'| Show (partial) command in status line
set sc

" [global] |'showmatch'|  when a bracket is inserted, briefly jump to the matching one 
set sm

" [global] |'showmode'| display current mode
set smd

" [global] |'sidescroll'| minimum number of columns to scroll horizontal
" set ss=0

" [global] |'sidescrolloff'| min. nr. of columns to left and right of cursor
set siso=4

" [global] |'smartcase'| Override the 'ignorecase' option if the search pattern contains
"                        upper case characters.
set scs

" [global] |'smarttab'| When on, a <Tab> in front of a line inserts blanks according to 
"                       'shiftwidth'.  'tabstop' is used in other places.
set sta

" [buffer] |'softtabstop'| Number of spaces that a <Tab> counts for while performing editing
"                          operations
set sts=8

" [global] |'switchbuf'| This option controls the behavior when switching between buffers. 
set swb=useopen
" 

" Options initiating with »t« 
" [glo-lo] |'tags'| :help tags Read it + understand it = add it!
set tag=./tags,tags

" Vim will open up as many tabs as you like on startup, up to the maximum
" number of tabs set in the .vimrc file. The default maximum is 10 tabs,
" but you can change this by setting the tabpagemax option
set tabpagemax=100

" [buffer] |'textwidth'| maximum width of text that is being inserted
set tw=72

" [global] |'ttyfast'| are we using a fast terminal? Yeppa!!!!11
set tf

" [buffer] |'tabstop'| number of spaces that a <Tab> in the file counts for
set ts=8

" [global] |'title'| When on, the title of the window will be set to the value of
"                    'titlestring' (if it is not empty)
set notitle

" [global] |'ttybuiltin'| When on, the builtin termcaps are searched before the external ones.
set tbi

" [global] |'ttyscroll'| Maximum number of lines to scroll the screen.
set tsl=999

" Options initiating with »u« 
" [global] |'undolevels'| undoing 1000 changes should be enough
set ul=1000

" [global] |'updatecount'| write swap file to disk after each 150 characters
set uc=150

" [global] |'updatetime'| write swap file to disk after 5 inactive seconds
set ut=5000
" 

" Options initiating with »v« 
" viminfo help:
" ! - Save and restore global variables that start with uppercase and does not have lower case characters.
" " - Maximum number of lines saved for each register.
" % - Save and restore buffer list.
" ' - Maximum number of edited files for which the marks are remembered.
" / - Maximum number of items in search pattern history.
" : - Maximum number of items in command-line history.
" @ - Maximum number of items in input-line history.
" c - Convert viminfo text from/to 'encoding'.
" f - Whether file marks need to be stored.
" h - Disable the effect of 'hlsearch' when loading viminfo file.
" n - Name of the viminfo file.
" r - Removable media. List of pathes for which no marks will be saved.
set viminfo=!,\"500,'50,/50,:500,@500,h


" [global] |'visualbell'| visual bell instead of beeping.. or nothing ;)
set novisualbell

" [global] |'virtualedit'| when to use virtual editing
set ve=block

" YES. I've a OpenVMS VAX V7.2 :-)
" | VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Jan 15 2004 11:53:14)
" | OpenVMS version
" | Included patches: 1-181
if has("unix")
        let vimrc='~/.vimrc'
else
        " for my VMS-Box (i. e. »if has("vms")«):
        let vimrc='sys$login:.vimrc'
endif
" 

" Options initiating with »w« 
" [global] |'wildchar'| type to start wildcard expansion in the command-line
set wc=<TAB>

" [global] |'writebackup'| make a backup before overwriting a file? no... thats for weenies ;)
set nowb


" [window] |'wrap'| this option changes how text is displayed
set nowrap


" [global] |'wildmenu'| When 'wildmenu' is on, command-line completion operates in an
"                       enhanced mode. 
set wmnu

" [global] |'wildmode'| have command-line completion <Tab> (for filenames, help topics, option
"                       names) first list the available options and complete the longest common 
"                       part, then have further <Tab>s cycle through the possibilities:
set wim=list:longest,full

" [global] |'whichwrap'| specified keys that move the cursor left/right to wrap
set ww=<,>,h,l

" [global] |'whichwrap'| minimum number of lines for the current window
set wh=5

" Misc Options 
" [buffer] ":syntax enable" will keep your current color settings.
syntax on

" Source some Files 
" Note: The "expand" is necessary to evaluate ~dope
"
" File: VBlockquote.vim (Insert (Quote) stuff the way some emacs people do)
let VBLOCK=expand("~/.vim/macros/VBlockquote.vim")
if filereadable(VBLOCK)
        exec "source " VBLOCK
endif

" File: browser_launcher.vim (Vim script to launch/control browsers.)
let BLAUNCH=expand("~/.vim/ftplugin/browser_launcher.vim")
if filereadable(BLAUNCH)
        exec "source " BLAUNCH
endif

" File: a.vim (foo.c -> foo.h)
" :A switches to the header file corresponding to the current file being edited (or vise versa)
" :AS splits and switches
" :AV vertical splits and switches
let AFILE=expand("~/.vim/macros/a.vim")
if filereadable(AFILE)
        exe "source " AFILE
endif

" File: tetris.vim ;-)
" Start a new game with »\te« (see »:h <Leader>« for details).
let TETRIS=expand("~/.vim/macros/tetris.vim")
if filereadable(TETRIS)
        exec "source " TETRIS
endif

" [buffer] type of file, used for autocommands
filetype plugin on
filetype indent on

" Use my own colorscheme
colorscheme wargrey
" colorscheme cabin
" colorscheme burnttoast256

" Let's be friendly :)
autocmd VimEnter * echo "Welcome back Chris :)"
autocmd VimLeave * echo "Cya in Hell."

" When editing a file, always jump to the last cursor position.
"autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
autocmd BufReadPost *
			\ if expand("<afile>:p:h") !=? $TEMP | 
			\ if line("'\"") > 0 && line("'\"") <= line("$") | 
			\ exe "normal g`\"" | 
			\ let b:doopenfold = 1 | 
			\ endif | 
			\ endif 
" Need to postpone using "zv" until after reading the modelines. 
autocmd BufWinEnter *
			\ if exists("b:doopenfold") | 
			\ unlet b:doopenfold | 
			\ exe "normal zv" | 
			\ endif
" 

" terminal stuff 
set t_Co=256

" Options for Vim 7.0 
if version >= 700
	let loaded_matchparen = 1
	" turn spelling on by default
	set nospell
	set spellfile=~/.vim/spellfile.add
	" change to german
	set spelllang=de
	set pumheight=7
	map <Leader>tn :tabnew<CR>
	map <Leader>tc :tabclose<CR>
	map <Leader>tw :tabnext<CR>
	" toggle spelling with F2 key
	map <F2> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
	" they were using white on white
	" highlight PmenuSel ctermfg=black ctermbg=lightgray
	" limit it to just the top 10 items
	set sps=best,10
	au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
	au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

" Mappings 
"
" /* shameless stolen from Sven Guckes */
" 2005-03-10 coloring whitespace,
" ie trailing spaces and tabs:
  highlight TrailSpace cterm=inverse ctermfg=magenta
  syn match TrailSpace /  *$/
" substitute the less-than and greater-than characters
" with their HTML equivalents in the current line:
" vmap ,,< :s/</\&lt;/g<CR>gv:s/>/\&gt;/g<CR>
" 2006-10-26 fadenkreuz an/aus
  map <esc><esc> :set cul! cuc!<cr>
hi cursorline    term=none ctermbg=blue
hi cursorcolumn  term=none ctermbg=red

" Fix trailing spaces <http://vim.wikia.com/wiki/VimTip878>
function TrimWhiteSpace() 
	: %s/\s*$// 
	: '' 
:endfunction 

" ,u = update by reading this file
 map ,u :source ~/.vimrc<CR>

" Toggle linenumbers with F6
nmap <F6> :set invnumber number?<CR>

" This is mapping to uuencode and uudecode in BASE64: 
" supports normal mode and visual mode. 
nnoremap <silent> <Leader>ue :%!uuencode -m /dev/stdout<CR> 
nnoremap <silent> <Leader>ud :%!uudecode -o /dev/stdout<CR> 
vnoremap <silent> <Leader>ue !uuencode -m /dev/stdout<CR> 
vnoremap <silent> <Leader>ud !uudecode -o /dev/stdout<CR>

" Load ~/.vim/macros/vimdiff.vim
  map ;LD :source ~/.vim/macros/vimdiff.vim<CR>
" Load ~/.vim/macros/morse.vim
  map ;LM :source ~/.vim/macros/morse.vim<CR>

" Fix a diff, making it easier to review.
" Add a blank line before each '@@ ... hunk line info ...@@' and each 'diff',
" making it easier to jump around using { and }
fun! ReviewDiff()
    let oldreg_val = getreg('d')
    let oldreg_type = getregtype('d')
    call setreg('d', '', 'V')
    g/^diff/put! d
    g/^@@/put! d
    call setreg('d', oldreg_val, oldreg_type)
endfun

" narf .. some morons insert more then one space in any text   and  i don't
" like it. This map's will runs of two or more space to a single space.
nmap <ESC>j vip:s/  \+/ /g<CR>
vmap <ESC>j    :s/  \+/ /g<CR>

" Quick insertion of an empty line
nmap <CR> o<ESC>

" trim blanks
map ,tr :%s/\s\+$//gic<CR>

" list files in current directory.
map ,ls :!/bin/ls<CR>

" Change into directory of current file
nmap ,cd :exe 'cd ' . expand ("%:p:h")<CR>:pwd<CR>

" Disable ZZ (too dangerous, might be typed when all I meant was zz)
map ZZ :"Sorry. no 'ZZ' today. Please stop cyring and piss off."<CR>

" Delete lines in insert-mode.
set <C-Right>=f
set <C-Left>=[1;5D
map <C-Left> b
map <C-Right> w

" Fxx Keys
" <F3> saves current buffer
nmap <F3> :w<CR>
imap <F3> <C-O>:w<CR>

" toggle highlight search (folke)
noremap <F4>  :if 1 == &hls \| noh \| else \| set hls \| endif \| <CR>

" Scroll in insert-mode
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

" Undo in insert mode.
imap <c-z> <c-o>u

" Nice Feature ;)
" Type (in the insert-mode) 4+4<C-B> and you will get the result.
"  Note: '<C-A>' won't work under screen because C-A C-A is a default
"        Keybinding of screen *g*
" '*' == sum            |       '+' == product
" '-' == difference     |       '/' == quotient
" '%' == remainder      |       '^' == scale(a^b) = min(scale(a)*b
inoremap <C-B> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" Press <Strg>_ and it will tell you the word under the cursor, and how long
" it is.
nmap <C-_> :echo 'word' expand("<cword>") '  wordlen =' strlen(expand("<cword>"))<CR>
vmap <C-_> "-y:echo 'word' @- '  wordlen =' strlen(@-)<CR>

" <F10>: quit buffer but prompt if changes have been made
nmap <F10> :confirm q<CR>
imap <F10> <Esc>:confirm q<CR>

" <C-F12> list all errors
nmap [24^ :clist!<CR>

" Esc is too hard to reach, so remap it. 
" Note: i use english keyboard layout, i mapped capslock to esc, this mapping
"       is only for some fucking german keyboards in my network :/
inoremap jj <esc>

" Often used filenames - only needed these on the command line:
" »:e _Mrc« == »:e /home/$USER/.muttrc«
cab Mrc ~/.muttrc
cab Src ~/.slrnrc
cab Zrc ~/.zshrc
cab Erc ~/.exrc
cab Vrc ~/.vimrc
cab Frc ~/.fvwmrc
cab Irc ~/.irssi/config
cab SRc ~/.screenrc
cab Nrc ~/.vim/macros/MailNews.vim
cab Spe ~/.vim/macros/vimspell.vim
" 

" Some function()'s 
func! Umlaute()
        exec "%s/ä/ae/gic"
        exec "%s/ö/oe/gic"
        exec "%s/ü/ue/gic"
        exec "%s/ß/ss/gic"
        exec "%s/Ä/Ae/gic"
        exec "%s/Ö/Oe/gic"
        exec "%s/Ü/Ue/gic"
endfunc

" VimTip 70: running a command on all buffers
" :call AllBuffers("%s/string1/string2/g")
" :call AllBuffers("%s/foo/bar/ge|update")
function AllBuffers(cmnd)
	let cmnd = a:cmnd
	let i = 1
	while (i <= bufnr("$"))
		if bufexists(i)
			execute "buffer" i
			execute cmnd
		endif
		let i = i+1
	endwhile
endfunction

" Removes those bloody ^M's
" :call RmCR()
fun RmCR()
    let oldLine=line('.')
    exe ":%s/\r//gic"
    exe ':' . oldLine
endfun

" Function for changing folding method.
if version >= 600
        function! ChangeFoldMethod() abort
                let choice = confirm("Which fold method?", "&manual\n&indent\n&expr\nma&rker\n&syntax", 2)
                if choice == 1
                        set foldmethod=manual
                elseif choice == 2
                        set foldmethod=indent
                elseif choice == 3
                        set foldmethod=expr
                elseif choice == 4
                        set foldmethod=marker
                elseif choice == 5
                        set foldmethod=syntax
                else
                endif
        endfunction
endif

" For the lastmod augroup 
function! LastMod()
        if line("$") > 1000
                let l = 1000
        else
                let l = line("$")
        endif
        exe "1," . l . "s/Last modified: .*/Last modified: " .  strftime("[ %Y-%m-%d %T ]") . "/e"
endfunction

" Fnord!
function DamnedWQ()
        let x = confirm("Current Mode ==  Insert-Mode!\n Would you like ':wq'?"," &Yes \n &No (yes means no and no means yes)",1,1)
        if x == 1
                silent! :wq
        else
                "???
        endif
endfun
iab wq <bs><esc>:call DamnedWQ()<CR>

" Abbreviations 
" date'n'time
" See strftime(3), date(1), printf(1), ctime(3),  getenv(3),
" printf(3), strptime(3) and so on for details.
" 22:28 
  iab Ytime <C-R>=strftime("%H:%M")<CR>
" 2003-09-25 22:28:38 
  iab _YDT   <C-R>=strftime("%Y-%m-%d %T")<CR>
" Thu 25 Sep 2003, 22:28:46 CEST 
  iab YDATe <C-R>=strftime("%a %d %b %Y, %T %Z")<CR>
" 2003-09-25 22:28:53 CEST 
  iab YDATE <C-R>=strftime("%Y-%m-%d %T %Z")<CR>
" 030925 
  iab Ydate <C-R>=strftime("%y%m%d")<CR>
" 030925 22:29:03  
  iab YDT   <C-R>=strftime("%y%m%d %T")<CR> 
" Saturday - July 12th 
  iab MDATE <C-R>=strftime("%A - %B %dth")<CR>
" [2003-07-12] 
  iab TST   <C-R>=strftime("[%Y-%m-%d]")<CR>
" July 12, 2003 (Saturday, 21:26h) 
  iab Y_DAT <C-R>=strftime("%B %d, %Y (%A, %H:%Mh)")<CR>
" I use this format in <http://strcat.de/papers.html>
  iab YHP <C-R>=strftime("%D")<CR>

" My personal homepages (Thx to Winfried Neessen for the webspace!)
  iab EMstrcat    strcat@gmx.net
  iab HPme        http://www.strcat.de/
  iab HPblog      http://www.strcat.de/blog/
  iab HPgpg       http://strcat.de/chris.gpg
  iab HPirssi     http://strcat.de/irssi/
  iab HPvim       http://strcat.de/vim/
  iab HPslrn      http://strcat.de/slrn/
  iab HPmutt      http://strcat.de/mutt/
  iab HPusenet    http://strcat.de/usenet.html
  iab HPhacks     http://strcat.de/hacks/
  iab HPpapers    http://strcat.de/papers.html
  iab HPzsh       http://strcat.de/zsh/
  iab HPscreen    http://strcat.de/screen/
  iab HPfvwm      http://strcat.de/fvwm/
  iab HPmisc      http://strcat.de/oth.html
  iab HPdau       http://strcat.de/logs/
  iab HPmfilter   http://strcat.de/mailfilter/
  iab HPrtfm      http://strcat.de/images/google.png

" Some simple example of the "expand modifiers":
" insert the current filename *with* path: »/home/dope/.vimrc«
  iab Ypathfile <C-R>=expand("%:p")<cr>
" insert the current filename *without* path: ».vimrc«
  iab Yfile <C-R>=expand("%:t:r")<cr>
" 

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
	" Statusline
	Plug 'itchyny/lightline.vim'
	" A simple, easy-to-use Vim alignment plugin.
	Plug 'junegunn/vim-easy-align'
	" jump around documents
	Plug 'Lokaltog/vim-easymotion'
	" https://github.com/junegunn/fzf
	Plug '~/.fzf'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	" https://github.com/tpope/vim-fugitive
	Plug 'tpope/vim-fugitive'
	" https://github.com/Valloric/YouCompleteMe
	Plug 'Valloric/YouCompleteMe'
	Plug 'majutsushi/tagbar'
	Plug 'scrooloose/nerdcommenter'
	Plug 'mbbill/undotree'
call plug#end()

" NERD Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

map <F5> :UndotreeToggle<CR>
if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif

let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

let g:lightline = {
      \ 'component_function': {
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \ },
      \ }

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction


nnoremap <silent> <leader>gs :Gstatus<CR> nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR> nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR> nnoremap <silent> <leader>gp :Git push<CR>


" Some plugin related stuff
" https://github.com/junegunn/vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" https://github.com/easymotion/vim-easymotion
" EasyMotion provides a much simpler way to use some motions in vim
map <Leader> <Plug>(easymotion-prefix)
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline


" Formatoptions
" Formatoptions for asciidoc (<http://www.methods.co.nz/asciidoc/>)
if has("autocmd")
	augroup templates
		autocmd BufNewFile *.adoc 0r ~/.vim/templates/asciidoc.adoc
	augroup END
endif
autocmd BufNewFile,BufRead ~/scripts/Asciidoc/*.txt,*.adoc
	\ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2
	\ | setlocal tabstop=8 softtabstop=2 shiftwidth=2 filetype=asciidoc
	\ | set textwidth=70 wrap formatoptions=tcqn
	\ | set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
	\ | set comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>
	\ | nnoremap Q gq}
	\ | set ft=asciidoc
	\ | source ~/.vim/macros/abbreviations.vim
	\ | nmap <F4> :make<CR>
	\ | inoremap <F4> <ESC>:make<CR><CR>a
	\ | set makeprg=asciidoctor\ -r\ asciidoctor-diagram\ %
	"\ | set makeprg=asciidoc\ -b\ xhtml11\ -d\ book\ -v\ -a\ data-uri\ --unsafe\ -a\ toc\ -a\ icons\ -a\ badges\ -f\ ~/.asciidoc/asciidoc.conf\ %

autocmd BufNewFile,BufRead ~/.tmux.conf set ft=tmux

" C(++)
function CInsert()
    let x = confirm("Which template?\n"," &Linux-Like \n &Unix-Like",1,1)
    if x == 1
    silent! 0r ~/.vim/templates/template-Linux.c
    else
    0r ~/.vim/templates/template-Unix.c
    endif
endfunc
autocmd BufRead *.c set tw=0
augroup c
    autocmd!
    autocmd BufNewFile,BufRead *.c,*.h,*.cc,*.cpp so $VIMRUNTIME/syntax/c.vim
    autocmd BufNewFile,BufRead *.c,*.h,*.cc,*.cpp set com=sr:/*,mb:*,ex:*/
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.cpp  setlocal cindent
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.cpp  setlocal cinoptions=>4,e0,n0,f0,{0,}0,^0,:4,=4,p4,t4,c3,+4,(2s,u1s,)20,*30,g4,h4
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.cpp  setlocal cinkeys=0{,0},:,0#,!<C-F>,o,O,e
    "autocmd BufNewFile *.c call CInsert()
    autocmd BufWritePre,FileWritePre *.c  exec("normal ms")|call LastMod()|exec("normal `s")
augroup END

" LaTeX
au FileType tex set dict+=~/.vim/dic/LaTeX.dic sw=2 sts=2 ai com=:% | syn sync maxlines=200 | syn sync minlines=50
augroup tex
    " <F5>:  Comment/uncomment current line
function! LaTeXCommentUncomment()
	if getline('.') =~ '^%'
		execute("normal |")
		execute("normal x")
		execute(line('.')+1)
	else
		execute("normal |")
		execute("normal i%")
		execute(line('.')+1)
	endif
endfunction " LaTeXCommentUncomment()

" <S-F5>:  Make the target corresponding to the current file (strips off
" the .tex extension;  if editing video.tex, will call make video
    autocmd FileType tex map  <S-F5> :execute(":make ".strpart(expand("%"), 0, match(expand("%"), ".tex")))<cr>
    autocmd FileType tex imap <S-F5> <Esc>:execute(":make ".strpart(expand("%"), 0, match(expand("%"), ".tex")))<cr>
augroup END
"

" HTML
function HTMLInsert()
   let x = confirm("Which Template?\n"," &Light \n &Dark",1,1)
   if x == 1
   silent! 0r ~/.vim/templates/template-light.html
   else
   0r ~/.vim/templates/template-dark.html
   endif
endfunc
augroup html
  autocmd!
  autocmd  BufNewFile,BufRead *.html,*.shtml hi htmlLink ctermfg=Black ctermbg=Cyan cterm=underline
  autocmd  BufNewFile,BufRead *.html,*.shtml so $VIMRUNTIME/syntax/html.vim
  autocmd  BufNewFile,BufRead *.html,*.shtml set tw=100 nowrap
  " autocmd  BufNewFile *.html,*.shtml,*.htm call HTMLInsert()
  autocmd  BufWritePre,FileWritePre *.html,*.shtml exec("normal ms")|call LastMod()|exec("normal `s")
augroup END
"

" XML
map <Leader>x :set filetype=xml<CR>
  \:source $VIMRUNTIME/syntax/xml.vim<CR>
  \:set foldmethod=syntax<CR>
  \:colors peachpuff<CR>
  \:source $ADDED/xml.vim<CR>
  \:iunmap <buffer> <Leader>.<CR>
  \:iunmap <buffer> <Leader>><CR>
  \:inoremap \> ><CR>


" catalog should be set up
nmap <Leader>l <Leader>cd:%w !xmllint --valid --noout -<CR>
nmap <Leader>r <Leader>cd:%w !rxp -V -N -s -x<CR>
nmap <Leader>d4 :%w !xmllint --dtdvalid
 \"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd" --noout -<CR>

vmap <Leader>px !xmllint --format -<CR>
nmap <Leader>px !!xmllint --format -<CR>
nmap <Leader>pxa :%!xmllint --format -<CR>
nmap <Leader>i :%!xsltlint<CR>
"

" CSS
function CSSInsert()
   let x = confirm("Which Template?\n"," &Light \n &Dark",1,1)
   if x == 1
   silent! 0r ~/.vim/templates/template-light.css
   else
   silent 0r ~/.vim/templates/template-dark.css
   endif
endfunc
augroup css
  autocmd!
  autocmd  BufNewFile,BufRead *.css so $VIMRUNTIME/syntax/css.vim
  autocmd  BufNewFile,BufRead *.css set tw=0 nowrap
  " autocmd  BufNewFile         *.css call CSSInsert()
  autocmd  BufWritePre,FileWritePre *.css exec("normal ms")|call LastMod()|exec("normal `s")
augroup END
"

" For CRUX Pkgfiles
autocmd BufNewFile Pkgfile 0r ~/.vim/templates/Pkgfile

" Mail and News
au FileType mail so ~/.vim/macros/MailNews.vim
if has("autocmd")
	au BufRead ~/.followup so ~/.vim/macros/message-nowplaying.vim | set spell
	au BufRead ~/tmp/neomutt-* so ~/.vim/macros/msgid.vim
	au BufRead ~/tmp/neomutt* set ft=mail | set spell | syntax on
	au BufRead ~/.article* so ~/.vim/macros/message-nowplaying.vim | set spell | syntax on
endif

" Slang
augroup slang
	autocmd BufRead *.sl,~/.slrnrc set ft=slang | set modeline
	autocmd BufRead *.sl,~/.slrnrc set com=sr:%,mb:%,ex:%
	autocmd BufRead ~/.slang/score set ft=slrnsc | set modeline
	autocmd BufRead ~/.slang/score nmap ;as oSubject: ^\<\><ESC>F\i | nmap ;as oSubject: \<\><ESC>F\i
	autocmd BufRead ~/.slang/score nmap ;af oFrom: ^\<\><ESC>F\i | nmap ;af oFrom: \<\><ESC>F\i
	autocmd BufRead ~/.slang/score nmap ;au oUser-Agent: ^\<\><ESC>F\i | nmap ;au oUser-Agent: \<\><ESC>F\i
	autocmd BufWritePre,FileWritePre *.sl,*.slrnrc  exec("normal ms")|call LastMod()|exec("normal `s")
augroup END
"

" Changelogs
augroup Changelog
  autocmd!
  autocmd BufNewFile,BufRead  Changelog     so ~/.vim/macros/Changelog.vim
  autocmd BufNewFile,BufRead  Changelog     set tw=72 nowrap
  autocmd BufNewFile,BufRead  Changelog     so $VIMRUNTIME/syntax/changelog.vim
augroup END
"

" Perl
au FileType perl set cink=0{,0},!,o,O
		\ | set cinw=if,else,elsif,while,do,foreach,switch,sub
		\ | set com=b:#
		\ | set kp=perldoc\ -f
		\ | set smartindent
		\ | set makeprg=$HOME/bin/vimparse.pl\ %\ $*
		\ | set errorformat=%f:%l:%m
augroup pl
  autocmd!
  autocmd BufNewFile,BufRead *.pl,*.pm let perl_want_scope_in_variables=1
  autocmd BufNewFile,BufRead *.pl,*.pm let perl_extended_vars=1
  autocmd BufNewFile,BufRead *.pl,*.pm so $VIMRUNTIME/syntax/perl.vim
  autocmd BufNewFile,BufRead *.pl,*.pm set tw=0 nowrap
  " autocmd BufNewFile         *.pl,*.pm 0r ~/.vim/templates/template.pl
  autocmd BufNewFile,BufRead *.pl,*.pm map <F1> :Perldoc<CR>
  autocmd BufNewFile,BufRead *.pl,*.pm setf perl
  autocmd BufNewFile,BufRead *.pl,*.pm let g:perldoc_program='/usr/local/bin/perldoc'
  autocmd BufNewFile,BufRead *.pl,*.pm source ~/.vim/ftplugin/perl_doc.vim
  autocmd BufWritePre,FileWritePre *.pl,*.pm  exec("normal ms")|call LastMod()|exec("normal `s")
  autocmd BufWrite           *.pl    !chmod +x %
  augroup END
"

" I use this to soon i edit my ~/.sigs/own-stuff
autocmd BufRead  ~/.sigs/own-stuff  set tw=80
autocmd BufWrite ~/.sigs/own-stuff  call LastMod()
