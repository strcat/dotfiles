" $Id: .vimrc,v 1.1 2002/09/27 02:13:02 dope Exp dope $
"
" Informations {{{
"    File: $HOME/.vimrc
"  Author: Christian Schneider <strcat(at)gmx.net>
" Purpose: setup file for the editor "vim"
"     URL: See https://github.com/strcat/dotfiles
"    Note: If your read this then please send me an email! I welcome all
"          feedback on this file - especially with new ideas such as abbreviations
"          and mappings.
"     Tip: Open this file with 'vim -c 'set foldmethod=marker' this-file' or -
"          if Vim already runnig - type ':set foldmethod=marker' for a /better/
"          oversight ;)
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
" | VIM - Vi IMproved 8.1 (2018 May 18, compiled Jan 21 2019 12:57:28)
" | Included patches: 1-772
" | Compiled by Christian Schneider <strcat@gmx.net>
" | Huge version without GUI.  Features included (+) or not (-):
" | +acl               +extra_search      +mouse_netterm     +tag_old_static
" | +arabic            +farsi             +mouse_sgr         -tag_any_white
" | +autocmd           +file_in_path      -mouse_sysmouse    -tcl
" | +autochdir         +find_in_path      +mouse_urxvt       +termguicolors
" | -autoservername    +float             +mouse_xterm       +terminal
" | -balloon_eval      +folding           +multi_byte        +terminfo
" | +balloon_eval_term -footer            +multi_lang        +termresponse
" | -browse            +fork()            -mzscheme          +textobjects
" | ++builtin_terms    +gettext           +netbeans_intg     +textprop
" | +byte_offset       -hangul_input      +num64             +timers
" | +channel           +iconv             +packages          +title
" | +cindent           +insert_expand     +path_extra        -toolbar
" | -clientserver      +job               +perl              +user_commands
" | -clipboard         +jumplist          +persistent_undo   +vartabs
" | +cmdline_compl     +keymap            +postscript        +vertsplit
" | +cmdline_hist      +lambda            +printer           +virtualedit
" | +cmdline_info      +langmap           +profile           +visual
" | +comments          +libcall           -python            +visualextra
" | +conceal           +linebreak         -python3           +viminfo
" | +cryptv            +lispindent        +quickfix          +vreplace
" | +cscope            +listcmds          +reltime           +wildignore
" | +cursorbind        +localmap          +rightleft         +wildmenu
" | +cursorshape       -lua               -ruby              +windows
" | +dialog_con        +menu              +scrollbind        +writebackup
" | +diff              +mksession         +signs             -X11
" | +digraphs          +modify_fname      +smartindent       -xfontset
" | -dnd               +mouse             +startuptime       -xim
" | -ebcdic            -mouseshape        +statusline        -xpm
" | +emacs_tags        +mouse_dec         -sun_workshop      -xsmp
" | +eval              -mouse_gpm         +syntax            -xterm_clipboard
" | +ex_extra          -mouse_jsbterm     +tag_binary        -xterm_save
" |    system vimrc file: "$VIM/vimrc"
" |      user vimrc file: "$HOME/.vimrc"
" |  2nd user vimrc file: "~/.vim/vimrc"
" |       user exrc file: "$HOME/.exrc"
" |        defaults file: "$VIMRUNTIME/defaults.vim"
" |   fall-back for $VIM: "/usr/local/share/vim"
" | Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H     -g -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
" | Linking: gcc   -Wl,-E -Wl,-rpath,/usr/lib/perl5/5.28/core_perl/CORE
" | 		-L/usr/local/lib -Wl,--as-needed -o vim        -lm -ltinfo -lnsl  -ldl
" | 		-Wl,-E -Wl,-rpath,/usr/lib/perl5/5.28/core_perl/CORE
" | 		-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now
" | 		-fstack-protector-strong -L/usr/local/lib
" | 		-L/usr/lib/perl5/5.28/core_perl/CORE -lperl -lpthread -ldl -lm -lcrypt
" | 		-lutil -lc
" `----
"  It was also compiled with:
"   | ./configure --without-x --with-compiledby='Christan Schneider <strcat@gmx.net>' \
"   |             --with-features=huge
"                       b:\" repeats " , requires blank
"   Strings that        b:#  repeats # , requires blank after #.
"   start a             :%   repeats %
"   comment line        fb:- first line only , requires blank
"                       fbn:* first line only , requires blank, nests
"                       n:>  repeats > , nesting allowed   eg "> > >"
"                       n:)  repeats ) , nesting allowed   eg ") > )"
"                                               Note the >     ^^^^^
"
" Settings {{{
set comments=b:\",b:#,:%,fbn:-,fb:*,n:>,n:),:\[---\ snip,:--\
set autoindent					" off as I usually do not write code
set autowrite					" on saves a lot of trouble
set autoread					" autom. read file when changed outside of Vim
set backspace=2					" how backspace works at start of line
set backup					" Make a backup (i. e. 'file~') and save it.
set cpoptions=aABceFsJWy			" flags for Vi-compatible behavior
"set nocompatible				" compatible to vi? Hey. If i want Vi, i'm *using* Vi and not Vim.
set cmdheight=2					" Disable the 'Press RETURN...' - Messages
set digraph					" required for those umlauts
set dict=/usr/share/dict/words			" list of file names used for keyword completion
set diffopt=filler,context:4,iwhite		" options for using diff mode
set display=lastline				" to display as much as possible of the last line in a window
						" instead of displaying the '@' symbols.
set fillchars=vert:\ ,fold:\ "			" characters to use for displaying special items
set formatoptions=cqrtc2			" Options for text format
set hidden					" dont close changed window
set history=500					" make the history longer
set incsearch					" dont highlight searchresults
set iskeyword=@,48-57,_,192-255,-,.,@-@		" enable the search for @, ., _ and -
set laststatus=2				" show statusline
set linebreak					" If on Vim will wrap long lines at a character in 'breakat' rather than at the
						" last character that fits on the screen.
"set list					" show <Tab> and <EOL>
"set listchars=tab:>-,trail:-			" This tells Vim which characters to show for expanded TABs, ...
set makeef="~/tmp/vim##.err"			" name of the errorfile for ":make"
set matchpairs=(:),[:],{:},<:>			" pairs of characters that "%" can match
set mouse=a					" Useful for tabline
set nu relativenumber				" Numbers && relativenumbers
set pastetoggle=<F2>				" exit paste-mode (<F7>)
set path+=**					" search down into subfolders
set report=0					" always report changes
set runtimepath=~/.vim,~/.vim/mySnippets,$VIMRUNTIME		" This is a list of directories which will be searched for runtime files:
scriptencoding utf-8				" set the right scriptencoding
set scrolloff=1					" minimum nr. of lines above and below cursor
set showtabline=2				" Show tabline
set splitbelow splitright			" splitting a window will put the new window below the current one
set nostartofline				" commands listed below move the cursor to the first blank of the line
set secure					" trust this current file, but no other
set shortmess=atIT				" list of flags, reduce length of messages
set shiftround					" round indent to multiple of shiftwidth
set showbreak=↪					" String to put at the start of lines that have been wrapped
set showcmd					" Show (partial) command in status line
set showmatch					" when a bracket is inserted, briefly jump to the matching one
set showmode					" display current mode
set sidescrolloff=4				" min. nr. of columns to left and right of cursor
set smartcase					" Override the 'ignorecase' option if the search pattern contains upper
						" case characters.
set smarttab					" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
set softtabstop=8				" Number of spaces that a <Tab> counts for while performing editing operations		" This option controls the behavior when switching between buffers.
syntax on					" :syntax enable will keep your current color settings.
set tabpagemax=100				" Vim will open up as many tabs as you like on startup, up to the maximum number
						" of tabs set in the .vimrc file.
set textwidth=72				" maximum width of text that is being inserted
set viminfo=!,\"500,'50,/50,:500,@500,h		" See »:h viminfo« for more details
set virtualedit=block				" when to use virtual editing
set wildchar=<TAB>				" type to start wildcard expansion in the command-line
set nowritebackup				" make a backup before overwriting a file? no... thats for weenies ;)
set nowrap					" this option changes how text is displayed
set wildmenu					" When 'wildmenu' is on, command-line completion operates in an enhanced mode.
set wildmode=list:longest,full			" have command-line completion <Tab> (for filenames, help topics, ...)
set whichwrap=<,>,h,l				" specified keys that move the cursor left/right to wrap
" }}}

" Misc stuff {{{
" type of file, used for autocommands
filetype plugin on
filetype indent on

" gx seems broken? idk..
nmap gx yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>

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
" }}}

" Colors, colorscheme, .. {{{
" terminal stuff
set t_Co=256
" set term=xterm-kitty

" needed for bracketed paste within tmux/screen
if &term =~ '^tmux'
  let &t_BE="\<Esc>[?2004h"
  let &t_BD="\<Esc>[?2004l"
  let &t_PS="\<Esc>[200~"
  let &t_PE="\<Esc>[201~"
endif

" Enable True Color in Vim in combination with st(-term)
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" colorscheme znake
colorscheme painless
" }}}

" Options for Vim 7.0 {{{
if version >= 700
	let loaded_matchparen = 1
	" turn spelling on by default
	set spellfile=~/.vim/spellfile.add
	" change to german
	set spelllang=de
	set pumheight=7
	" toggle spelling with F2 key
	map <F2> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
	" they were using white on white
	" highlight PmenuSel ctermfg=black ctermbg=lightgray
	" limit it to just the top 10 items
	set sps=best,10
	let &t_Cs = "\e[4:3m"
	let &t_Ce = "\e[4:0m"
	hi SpellBad     gui=undercurl guisp=red term=undercurl cterm=undercurl
endif
" }}}

" Mappings {{{
" 2006-10-26 fadenkreuz an/aus
  map <esc><esc> :set cul! cuc!<cr>

" Fix trailing spaces <http://vim.wikia.com/wiki/VimTip878>
function TrimWhiteSpace()
	: %s/\s*$//
	: ''
:endfunction

" ,u = update by reading this file
 map ,u :source ~/.vimrc<CR>

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

" Change into directory of current file
nmap ,cd :exe 'cd ' . expand ("%:p:h")<CR>:pwd<CR>

" Disable ZZ (too dangerous, might be typed when all I meant was zz)
map ZZ :"Sorry. no 'ZZ' today. Please stop cyring and piss off."<CR>

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

" Esc is too hard to reach, so remap it.
" Note: i use english keyboard layout, i mapped capslock to esc, this mapping
"       is only for some fucking german keyboards in my network :/
inoremap jj <esc>

" Often used filenames - only needed these on the command line:
" »:e _Mrc« == »:e /home/$USER/.muttrc«
cab Mrc ~/.muttrc
cab Src ~/.slrnrc
cab Zrc ~/.zshrc
cab Vrc ~/.vimrc
cab Irc ~/.irssi/config
cab Nrc ~/.vim/macros/MailNews.vim
cab Spe ~/.vim/macros/vimspell.vim
" }}}

" Some function()'s {{{
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

" For the lastmod augroup
function! LastMod()
        if line("$") > 1000
                let l = 1000
        else
                let l = line("$")
        endif
        exe "1," . l . "s/Last modified: .*/Last modified: " .  strftime("[ %Y-%m-%d %T ]") . "/e"
endfunction
" }}}

" Abbreviations {{{
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
" }}}

" Plugins {{{
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
	Plug 'tpope/vim-surround'
	Plug 'liuchengxu/vista.vim'
	Plug 'rbgrouleff/bclose.vim'
	Plug 'voldikss/vim-floaterm'
	Plug 'cespare/vim-toml'
	Plug 'mattn/emmet-vim'
	Plug 'junegunn/goyo.vim'
	Plug 'tpope/vim-repeat'
	Plug 'itchyny/lightline.vim'
	Plug 'junegunn/vim-easy-align'
	Plug '~/.fzf'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'majutsushi/tagbar'
	Plug 'scrooloose/nerdcommenter'
	Plug 'mbbill/undotree'
	Plug 'mattn/webapi-vim'
	Plug 'prettier/vim-prettier'
	Plug 'ryanoasis/vim-devicons'
	Plug 'taohexxx/lightline-buffer'
	Plug 'roxma/vim-hug-neovim-rpc'
	Plug 'roxma/nvim-yarp'
	" Plug 'Shougo/deoplete.nvim'
	Plug 'airblade/vim-gitgutter'
	" Plug 'SirVer/ultisnips'
	" located under ~/.vim/plugged/vim-snippets/snippets/
	Plug 'honza/vim-snippets'
	" Plug 'ervandew/supertab'
	Plug 'w0rp/ale'
	Plug 'vim-pandoc/vim-pandoc'
	Plug 'andymass/vim-matchup'
	Plug 'maximbaz/lightline-ale'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
	Plug 'romainl/vim-devdocs'
	Plug 'foosoft/vim-argwrap'
	Plug 'jiangmiao/auto-pairs'
	Plug 'luochen1990/rainbow'
	Plug 'tpope/vim-markdown'
	Plug 'easymotion/vim-easymotion'
        Plug 'reedes/vim-pencil'
	Plug 'kovetskiy/sxhkd-vim'
	Plug 'vifm/vifm.vim'
	Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'antoinemadec/coc-fzf'
	" if has ('nvim')
	"         Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
	" endif
call plug#end()
let g:Hexokinase_highlighters = ['backgroundfull']

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" Vista
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" spelcheck is usless!!!111!
let g:pandoc#spell#enabled = 0

" Configure Rainbow Parenthese
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['red', 'blue', 'yellow', 'cyan', 'magenta', 'lightred', 'lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}
" Enable Rainbow Parenthesis
let g:rainbow_active = 1

" Disable unused builtin plugins
 " Read/Write compressed files
 let g:loaded_gzip              = 1
 let g:loaded_tar               = 1
 let g:loaded_tarPlugin         = 1
 let g:loaded_zip               = 1
 let g:loaded_zipPlugin         = 1
 " Create a self-installing Vim script
 let g:loaded_vimball           = 1
 let g:loaded_vimballPlugin     = 1
 " Download latest version of VIM scripts
 let g:loaded_getscript         = 1
 let g:loaded_getscriptPlugin   = 1

" vifm
nnoremap <Leader>vf :Vifm<CR>
nnoremap <Leader>F :FloatermNew vifm<CR>
let g:vifm_embed_split = 1
let g:vifm_embed_term =1 

" Autopairs 
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

" Prettier
let g:prettier#config#use_tabs = 'false'

" argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" vim-devdocs
" nmap K <Plug>(devdocs-under-cursor)
nmap ;k :DD<CR>

" vim-latex-live-preview
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'zathura'

" ALE releated stuff.. {{{
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint', 'prettier']
let g:ale_fixers['typescript'] = ['prettier', 'tslint']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['html'] = ['tidy']
let g:ale_fixers['vue'] = ['prettier']
let g:ale_fixers['css'] = ['stylelint', 'prettier']
let g:ale_fixers['less'] = ['prettier']
let g:ale_fixers['scss'] = ['prettier']
let g:ale_fixers['graphql'] = ['prettier']
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['yaml'] = ['prettier']
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_delay = 500
let g:ale_echo_cursor = 1
let g:ale_echo_delay = 200
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['✖%d', '⚠ %d', '✓ ok']
let g:ale_linters = {
  \ 'c':        ['clang'],
  \ 'cpp':      ['clang'],
  \ 'zsh':      ['shell'],
  \ 'sh':       ['shell'],
  \ 'rust':     ['rls'],
  \ 'python':   ['pylint'],
  \ 'scala':    ['sbtserver'],
  \ 'markdown': [''],
  \ 'pandoc':   [''],
  \ 'tex':      [''],
  \ 'bib':      ['']
\}

" Ctrl+j and Ctrl+k to moving between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" }}}

" Markdown preview
" do not close the preview tab when switching to other buffers
let g:mkdp_auto_close = 0

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<nop>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetsDir="~/.vim/mySnippets"
" let g:UltiSnipsSnippetDirectories=['UltiSnips', 'mySnippets']

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Lightline, Bufferline, vim-devicons, .. {{{
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

let g:lightline = {
    \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction' ],
      \             [ 'fugitive', 'readonly', 'absolutepath', 'modified' ], ],
      \  'right': [ [ 'lineinfo' ], [ 'filetype', 'percent' ],
      \             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ],
      \ },
    \ 'tabline': {
    \   'left': [ [ 'bufferinfo' ],
    \             [ 'separator' ],
    \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
    \   'right': [ [ 'close' ], ],
    \ },
    \ 'component_expand': {
    \   'buffercurrent': 'lightline#buffer#buffercurrent',
    \   'bufferbefore': 'lightline#buffer#bufferbefore',
    \   'bufferafter': 'lightline#buffer#bufferafter',
    \  'linter_checking': 'lightline#ale#checking',
    \  'linter_warnings': 'lightline#ale#warnings',
    \  'linter_errors': 'lightline#ale#errors',
    \  'linter_ok': 'lightline#ale#ok',
    \ },
    \ 'component_type': {
    \   'buffercurrent': 'tabsel',
    \   'bufferbefore': 'raw',
    \   'bufferafter': 'raw',
    \   'readonly': 'error',
    \     'linter_checking': 'left',
    \     'linter_warnings': 'warning',
    \     'linter_errors': 'error',
    \     'linter_ok': 'left',
    \ },
    \ 'component_function': {
    \   'method': 'NearestMethodOrFunction',
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
    \   'bufferinfo': 'lightline#buffer#bufferinfo',
    \   'gitbranch': 'fugitive#head',
    \   'cocstatus': 'coc#status',
    \   'currentfunction': 'CocCurrentFunction',
    \   'fugitive': 'LightlineFugitive'
    \ },
    \ 'component': {
    \   'separator': '',
    \ },
    \ }
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''


endfunction

" Icons for my bufferline
let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '

" nable devicons, only support utf-8
" require <https://github.com/ryanoasis/vim-devicons>
let g:lightline_buffer_enable_devicons = 1
" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
" :help filename-modifiers
let g:lightline_buffer_fname_mod = ':t'
" hide buffer list
let g:lightline_buffer_excludes = ['vimfiler']
" max file name length
let g:lightline_buffer_maxflen = 30
" max file extension length
let g:lightline_buffer_maxfextlen = 3
" min file name length
let g:lightline_buffer_minflen = 16
" min file extension length
let g:lightline_buffer_minfextlen = 3
" reserve length for other component (e.g. info, close, ..)
let g:lightline_buffer_reservelen = 20
" }}}

" Mappings for turning Limelight and GoYo on/off {{{
  map <leader>l :Limelight!!0.9<CR>
  map <leader>g :Goyo \| set linebreak<CR>
" increase width
let g:goyo_width = '70%'
" Goyo and Limelight together
 autocmd! User GoyoEnter Limelight!!0.9
 autocmd! User GoyoLeave Limelight!
" }}}

" Deoplete {{{
" let g:deoplete#enable_at_startup = 1
" inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-i>"
" }}}

" Emmet {{{
" Enable emmet just for html/css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Redefine trigger key. Default is CTRL+y followed by `,` (comma), which
" is.. doh'. So now is the triggerkey also a ","; simple press ,, (two
" commas)
let g:user_emmet_leader_key=','
"let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.snippets_custom.json')), "\n"))
let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.snippets_custom.json')), "\n"))
" }}}

" NERD Commenter {{{
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
" }}}

" UndotreeToggle {{{
map <F5> :UndotreeToggle<CR>
let g:undotree_SplitWidth = 40
let g:undotree_DiffpanelHeight = 15
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 3
if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif
" }}}

" Tagbar {{{
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
" }}}

" FZF {{{
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

" Mappings for FZF
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <Leader>h :History<CR>
nnoremap // :BLines<CR>

" or https://vim.fandom.com/wiki/Cycle_through_buffers_including_hidden_buffers
 " Tab
 nnoremap <Tab> :bnext<CR>
 " Shift-Tab
 nnoremap <S-Tab> :bprevious<CR>
" }}}

" https://github.com/junegunn/vim-easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" autocommandos.. {{{
" Automatically deletes all trailing whitespace on save¿ because no one
" need whitespaces!
"autocmd BufWritePre * %s/\s\+$//e

" Go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
augroup go
	autocmd!
	" Show by default 4 spaces for a tab
	autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
	" :GoBuild and :GoTestCompile
	autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
	" :GoTest
	autocmd FileType go nmap <leader>t  <Plug>(go-test)
	" :GoRun
	autocmd FileType go nmap <leader>r  <Plug>(go-run)
	" :GoDoc
	autocmd FileType go nmap <Leader>d <Plug>(go-doc)
	" :GoCoverageToggle
	autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
	" :GoInfo
	autocmd FileType go nmap <Leader>i <Plug>(go-info)
	" :GoMetaLinter
	autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
	" :GoDef but opens in a vertical split
	autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
	" :GoDef but opens in a horizontal split
	autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
	" :GoAlternate  commands :A, :AV, :AS and :AT
	autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
	autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
	autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
	autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END
" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" Ruby/Erb: 2.. TWO FUCKING SPACES!
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2

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
	\ | map <Leader>c :!asciidoctor %<CR>
	\ | map <Leader>b :!asciidoctor-pdf %<CR>

autocmd BufNewFile,BufRead ~/.tmux.conf set ft=tmux

" fuck you you fucking fuck
autocmd BufRead ~/.config/polybar/config set ft=dosini

" Pandoc
augroup pandoc_syntax
	au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc tw=100
	map ;; :%s+<blockquote>+{{< blockquote author="" link="" >}}\r+gic \| %s+</blockquote>+{{< /blockquote >}}\r+gic<CR>
	map ;a otags:<ESC>\|/---
	map ;w i class="input"<ESC>
augroup end

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

" HTML
augroup html
  autocmd!
  autocmd  BufNewFile,BufRead *.html,*.shtml hi htmlLink ctermfg=Black ctermbg=Cyan cterm=underline
  autocmd  BufNewFile,BufRead *.html,*.shtml so $VIMRUNTIME/syntax/html.vim
  autocmd  BufNewFile,BufRead *.html,*.shtml set tw=10000 nowrap
  " autocmd  BufNewFile *.html,*.shtml,*.htm call HTMLInsert()
  autocmd  BufWritePre,FileWritePre *.html,*.shtml exec("normal ms")|call LastMod()|exec("normal `s")
augroup END

" CSS
augroup css
  autocmd!
  autocmd  BufNewFile,BufRead *.css so $VIMRUNTIME/syntax/css.vim
  autocmd  BufNewFile,BufRead *.css set tw=0 nowrap
  " autocmd  BufNewFile         *.css call CSSInsert()
  autocmd  BufWritePre,FileWritePre *.css exec("normal ms")|call LastMod()|exec("normal `s")
augroup END

" Mail and News
au FileType mail so ~/.config/nvim/macros/MailNews.vim
if has("autocmd")
	au BufRead ~/.followup so ~/.config/nvim/macros/message-nowplaying.vim | set spell | set nonu nornu
	au BufRead ~/tmp/neomutt-* so ~/.config/nvim/macros/msgid.vim
	au BufRead ~/tmp/neomutt-* so ~/.config/nvim/macros/VBlockquote.vim
	au BufRead ~/tmp/neomutt* set ft=mail | set spell | syntax on | set nonu nornu
	au BufRead ~/.article* so ~/.config/nvim/macros/message-nowplaying.vim | set spell | syntax on
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

" Automatically wrap at 72 characters and spell check git commit messages
autocmd FileType gitcommit setlocal textwidth=72
autocmd FileType gitcommit setlocal spell

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

" I use this to soon i edit my ~/.sigs/own-stuff
autocmd BufRead  ~/.sigs/own-stuff  set tw=80
autocmd BufWrite ~/.sigs/own-stuff  call LastMod()
" }}}
