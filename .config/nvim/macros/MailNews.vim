" $Id: MailNews.vim,v 1.3 2002/06/29 02:05:00 dope Exp dope $
"
" File   : ~/.vim/macros/MailNews.vim
" Purpose: facilitate editing mails and postings
" Author : Christian Schneider <strcat@gmx.net>
"
" Load this file with ':so /path/to/MailNews.vim' or add 
" | au FileType mail so ~/.vim/macros/MailNews.vim 
" in your ~/.vimrc
" 
" Used and tested with 
" VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Oct 11 2003 18:36:20) under
" OpenBSD 3.4-current (OpenBSD painless.my-fqdn.de 3.4 PAINLESS#0 i386 AMD
" Athlon XP Model 6 (Palomino) ("AuthenticAMD" 686-class))
" and
" VIM - Vi IMproved 6.3 (2004 June 7, compiled Jun 19 2004 12:36:49) under 
" Linux version 2.6.7 (root@dreckskind) (gcc version 3.2.3) #3 SMP Thu Jun 17 
" 09:15:52 CEST 2004
"
" Hint: Some parts are shameless stolen from 
"        * Sven Guckes    (<http://www.guckes.net/>).
"        * Andre Kuehnert (<http://www.andruschs.de/>)
"        * Ralf Arens     (<http://home.tu-clausthal.de/~mwra/>)
"        * Thomas Bader   (<http://trash.net/~thomasb/>)
"        * Michael Prokop (<http://www.michael-prokop.at/>)
"        * Luc's Hermitte (<ttp://hermitte.free.fr/vim/>)
"        * Vim - Page     (<http://www.vim.org/tips/index.php>)
"
" Note to self: 'K' is mapped to 'man -s'. To change, set another value with
"               'set keywordprg=foobar\ -parm'.
"
" Last modified: [ 2006-05-14 19:16:05 ]
"
" Note: This file is *extremely* under construction! It's also a playground
"       for my mental trips ;)
" TODO: * Correct the ',f' - map that ignore my own signature. 
"       * Look back for a reparation for ',el' - vmap. It works only on and of

" At first, some settings
" »>« and »|« are comments. »fb:-« formats a list that starts with '- '.
  setlocal com=n:>,n:\|,fb:-
" No C-like indent
  setlocal nocindent
" Formatoptions:
"       »tc«: automatic formatting for text and comments
"       »r«.: Automatically insert the current comment leader after hitting
"             <Enter> in Insert mode.
"       »q«.: Allow formatting of comments with "gq".
  setlocal fo=tcrq
" number of spaces to use for (auto)indent step 
  setlocal sw=4
" This file include my subscribed newsgroups.
  setlocal dictionary=~/.vim/macros/ngs
" Show expanded TABs and trailing whitespace
  " setlocal listchars=tab:»·,trail:·
" enable autmatic quote folding
"  ,----[ Example ]
"  | Thus spake John Doe (me@privacy.net):
"  | +--  9 lines: > "Nick Name" <nick@foobar.invalid> writes: 
"  `----
"  setlocal foldmethod=expr
"  setlocal foldexpr=strlen(substitute(substitute(getline(v:lnum),'\\s','',\"g\"),'[^>].*','',''))
"  setlocal foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
"  setlocal fillchars=

" Load some files. See »:h filereadable« for details
"  +--> Make footnotes in Vim
  " let FOOTNOTE=expand("~/.vim/macros/vimfootnotes.vim")
  " if filereadable(FOOTNOTE) | exe "source " . FOOTNOTE | endif
"
" +--> Insert (Quote) stuff the way some emacs people do.
  let BLOCKQUOTE=expand("~/.vim/macros/VBlockquote.vim")
  if filereadable(BLOCKQUOTE) | exe "source " . BLOCKQUOTE | endif
"
" +--> Merge the occurencies of "Re:" and "Re[n]" within e-mails'subject in
"      only one.
  let RE=expand("~/.vim/macros/Mail_Re.set.vim")
  if filereadable(RE) | exe "source " . RE | endif
"
" +--> Quote handling stuff
  let MQUOTE=expand("~/.vim/macros/Mail_quotes.vim")
  if filereadable(MQUOTE) | exe "source " . MQUOTE | endif
"
" +--> Some often used (and needed) abbreviations
  let IABS=expand("~/.vim/macros/abbreviations.vim")
  if filereadable(IABS) | exe "source " IABS | endif

" figlet is evil ;)
" Press 'f' (or 'F') to pipe the line at the cursor to figlet
map <ESC>f :.! figlet<CR>
map <ESC>F :.! figlet -w 72<CR>

" Insert some files (requires manual completion)
nmap ,at :r ~/.vim/forms/

" The Attach me mode.
map __a_start :imap <C-V><CR> <C-O>__a_cmd\|imap <C-V><ESC> <C-V><ESC>__a_end\|imap <C-V><C-V><C-V><C-I> <C-V><C-N>\|imap <C-V><C-N> <C-V><C-X><C-V><C-F><CR>
noremap __a_end :iunmap <C-V><CR>\|iunmap <C-V><ESC>\|iunmap <C-V><C-V><C-V><C-I>\|iunmap <C-V><C-V><C-V><C-N><CR>dd`a:"Attach mode ended.<CR>
noremap __a_cmd oAttach:<Space>
noremap __a_scmd 1G/^$/<CR>:noh<CR>OAttach:<Space>
map ,a ma__a_start__a_scmd

" Adding Signatures from within Vim using agrep. Yes.. i know.. 'z'
" is connected with folding, but .. ;)
nmap ,z  :r!/home/dope/bin/random-signature.pl; < ~/.signature<CR>
nmap ,s  :r!agrep -d "^-- $" '' ~/.sigs/own-stuff<S-LEFT><left><left>
nmap ,1  :r!agrep -d "^-- $" 'Eiffel' ~/.sigs/own-stuff
nmap ,2  :r!agrep -d "^-- $" LOVE-LETTER-FOR-YOU.txt ~/.sigs/own-stuff<CR>
nmap ,3  :r!agrep -d "^-- $" 'Gladiator;echo' ~/.sigs/own-stuff
nmap ,4  :r!agrep -d "^-- $" 'Windows;nice' ~/.sigs/own-stuff
nmap ,5  :r!agrep -d "^-- $" 'Let;me' ~/.sigs/own-stuff
nmap ,6  :r!agrep -d "^-- $" 'TECHNOLOGY' ~/.sigs/own-stuff
nmap ,7  :r!agrep -d "^-- $" Anfaenger ~/.sigs/own-stuff
nmap ,8  :r!agrep -d "^-- $" 'Usenet;1x1' ~/.sigs/own-stuff
nmap ,9  :r!agrep -d "^-- $" Genpool ~/.sigs/own-stuff

" ^D (<STRG-d>) delete complete text (without my own signature). Yes. I know
" .. C-d is mapped to scroll window Downwards in the buffer, but ... ;-)
imap <C-d> <Esc>VG?-- <CR>kdi<CR><UP><CR>
map <C-d> <Esc>VG?-- <CR>kdi<CR><UP><CR>

" . o O (  Boobles like Gnus ;) )
vmap ,ll :s/.*/\. o O \( & \)/<CR>

" :wq fast into mails and news.
nmap <F4> :wq<Cr>
imap <F4> <C-O>:wq<CR>

" reversing a selected block of text
" txet fo kcolb detceles a gnisrever "
vmap ## :!perl -nle 'print scalar reverse $_'<CR>

" shorten an URL using Metamark
" WWW::Shorten is a interface to URL shortening sites (*very* usefull!).
vmap _xrl :r!perl -MWWW::Shorten=Metamark -e 'print makeashorterlink q(<C-R>*)'

" Delete quotet but empty lines (start on line '15'). 
"  ,----[ Example ]
"  |  12: User-Agent: Mutt/1.5.4i (OpenBSD 3.2) # <= My 'User-Agent' - String 
"  |  13:                                       # <= A empty Line      
"  |  14: Thus spake 'name vorname (email)':    # <= My Attributionline   
"  |  15: ( Quotet empty lines will be deletet) # <= Start at this line
"  `----
map ,f :15 ,$g/^[<C-I> >]*$/d<CR>

" ,co = "clear empty lines" - deletes all empty or "whitespace only" lines
cmap ,co g/^[<C-I> ]*$/d

" ,sl   = squeeze lines - join multiple empty lines
"         /^$/, search empty line
"         /./-  line before next nonempty line ('-' is offset)
"        j      join them
nmap ,sl :g/^$/,/./-j
vmap ,sl :g/^$/,/./-j

" Save a copy in ~/MuttMail/Private
map ;p gg}OFcc: =/Private

" Jason "triple-dots" King elephant@onaustralia.com.au
" does uses ".." or "..." rather than the usual punctuation
" (comma, semicolon, colon, full stop). So...
"
" Turning dot runs with following spaces into an end-of-sentence,
" ie dot-space-space:
vmap ,dot :s/\.\+ \+/.  /g

" Gary Kline (kline@tera.tera.com) indents his
" own text in replies with TAB or spaces.
" Here's how to get rid of these indentation:
vmap ,gary :s/^>[ <C-I>]\+\([^>]\)/> \1/

" Inserting an ellipsis to indicate deleted text
" Mark a Text(-Block) in visual-mode and then press ',el'
vmap ,el c[...]
vmap ;el c> [ 

" Mark some lines for quotes
vmap ,QQ <ESC>'<O--- Quote begin ---<ESC>'>o--- Quote end ---<ESC><CR>

" format news - formats from headers until my own signature
nmap ,Qn mz1G}gq/^-- $<CR>'z

" »:8r«          Insert the file after line eight. 
" »:/^-- $/,$d«  Search / remove existing signature
" »<Esc>,2«      See 'nmap ,2'
" »gg«           Goto top
" »/^$<Esc>«     Goto first emtpy line (above my attribution-line)
map \] :8r ~/.vim/forms/lart-outlook \| :/^-- $/,$d \| <Esc>,2 \| gg \| /^$<Esc>
"map #+ :8r ~/.vim/forms/lart-outlook \| :/^-- $/,$d \| <Esc>,2 \| gg \| /^$<Esc>

" ,D = "clear quoted empty lines"
" deletes all lines which start with '>' and any amount of following spaces
" the vmap definition allows to apply this to visual selected text only.
nmap ,D :%s/^> *$//<Cr>
vmap ,D :s/^> *$//<Cr>

" Fix Supercite aka PowerQuote 
" Note: This map modified the *complete* Text!
map ,kqp :.,$s/^> *[a-zA-Z]*>/> >/<C-M>

" Formatting the current paragraph according to the current 'textwidth' 
" with ^J (control-j)
imap <C-J> <c-o>gqap
map <C-J> gqap
vmap <C-J> gq

" Fucking Outlook-Luser *narf*
" ,----[ Before: ]
" | * Thus spake Vorname Nachname (email@adres.se):
" | >
" | > "Fucking Luser" <with.outlook@expre.ss> schrieb im Newsbeitrag
" | > news:58k$180cc0o58k$180@ID-0815.nntp.server.tdl...
" | > (orignal message)
" `----
"  
" ,----[ After: ]
" | * Thus spake Vorname Nachname (email@adres.se):
" | >
" | > "Fucking Luser" <with.outlook@expre.ss> schrieb:
" |
" | [ Attribution-Line via »map« automatisch repariert. ]
" | Es heisst Einleitungszeile und nicht Roman. Die Message-ID ist
" | redunant, weil die bereit im Header enthalten ist. Bitte lesen und
" | aendern:
" |  - <http://www.volker-gringmuth.de/usenet/techrules.htm#zitat>
" |
" | > (orignal message)
"  `----
"map ,fo 1G \| /schrieb im Newsbeitrag<ESC> \| :s/schrieb im Newsbeitrag/schrieb:/g \| /^> news:<ESC> \| cc_attri<CR>
map ,fo :g/> schrieb im Newsbeitrag/s/schrieb im Newsbeitrag/schrieb:/g \| /^> news:<ESC> \| ccHattri<CR>

" search for the signature pattern (takes into account signature delimiters
" from broken mailers that forget the space after the two dashes)
" I use it for mutt; alternatively change the 'editor' - string in you ~/.muttrc
" to
" | set editor="vim -c '/^> -- $/,\$d'"
" Disadvantage of the 'set editor' - variant: 
"  * It create a error-message on new mail without a signature.
"  * It's not possible to 'undo' the sigdelete.
function! Mutt_Sig_Kill()
  let i = 0
  while ((i <= line('$')) && (getline(i) !~ '^> *-- \=$'))
    let i = i + 1
  endwhile
  if (i != line('$') + 1)
    let j = i
    while (j < line('$') && (getline(j + 1) !~ '^-- $'))
      let j = j + 1
    endwhile
    while ((i > 0) && (getline(i - 1) =~ '^\(>\s*\)*$'))
      let i = i - 1
    endwhile
    exe ':'.i.','.j.'d'
  endif
endfunction
call Mutt_Sig_Kill()

" <http://groups.google.de/groups?selm=30vri9.5p61.ln%40mid.wasserhase.de>
iab falsch <C-R>=Falsch("falsch")<CR>
iab Falsch <C-R>=Falsch("Falsch")<CR>
fun Falsch(s)
    let s = a:s
    let l = localtime()
    let t = strpart(l, strlen(l) - 4, 4) * line2byte(line("$") +1)
    let n = ""
    while strlen(s) > 1
        let i = t % strlen(s)
        let n = n . s[i]
        let s = substitute(s, s[i], "", "")
        let t = t / 10
    endwhile
    return n . s
endfun

" change subject line
" Before: Subject: old
" After : Subject: New (was: old)
" map ,sw 1G/^Subject: <CR>:s/Re:/was:/<CR>Wi (<C-O>$)<ESC>0Whi
map ;ns 1G/^Subject: /<CR>:s,\(Subject: \)\(Re: \)*\(.*\)$,\1(was: \3),<CR>f(i

" Delete 'was' in the Subject.
" Before: Subject: New (was: old)
" After : Subject: New
map ;dw 1G/^Subject: /<CR>:s,(was: .*)$<CR>f l

" Add a "X-Uptime" - Header .. sometimes ;)
map ,up 1G/^$<cr>OX-Uptime:<esc>:r!uptime<cr>kJ

" ,cs  = change Subject: line of meaningless Subject:
map ,cS 1G/^Subject: <CR>yypIX-Old-<ESC>-W
 
" Add a personal greeting. This one works with
"  * Thus spake Foo Bar <foo@bar.tdl>
" but *not* with 
"  * Name Vorname <foo@bar.tdl> wrote:
" Use ../e+1<CR>.. instead.
map ;HI G/^\Thus spake /e+1<CR>ye1G}oHi ,<ESC>Po<ESC>

" Change "From:"
map ,tF 1G/^From: /e+1<CR>Christian 'strcat' Schneider <strcat@gmx.net><ESC>
map ,ll 1G/^From: /e+1<CR>Christian 'strcat' Schneider <esc>:r!echo "<To-use-a-tool-like---`perl -lne '/u/i or next;int rand++$l or$u=$_;END{print "$u"}' /usr/share/dict/4bsd`--is-so-damned-uncool@strcat.de>"<CR>kJ

" Make Message "urgent"
map ,mlu 1G}OPriority: urgent<ESC>

" ,fq   = fix quoting - Fix various other quote characters:
vmap ,fq :s/^\(\( *>\)*\)\s*\([-"\|:}\%]\s*\)/\1> /e<CR>

" Kill quoted signature
map ,kqs G?^> *-- $<CR>dG

" Only needed for the WMI-mailinglist
map ;ks G?^> _______________________________________________<CR>4dd

" translate word under cursor (english -> german)
map -t :!translate <cword><CR>

" translate word under cursor (german -> english)
map -T :!translate -l de-en  <cword><CR>

" insert a 'Now-Playing:' - Line. I need it for 'w3m', because i post
" in some webboards.
nmap ,P :r!echo "Now-Playing: `cat ~/.now_playing`"<Cr>

"Insert separator line (comment mark and space first)
iab     Y-"             <ESC>71a"<ESC>A
iab     Y-%             <ESC>71a%<ESC>A
iab     Y-#             <ESC>71a#<ESC>A
iab     Y-!             <ESC>71a!<ESC>A
iab     Y--             <ESC>71a-<ESC>A

" Useful for a followup to de.alt.netdigest ;)
function! UnquoteMailBody() range abort
        " Every backslash character must be escaped in function -- Nepto
        "exec "normal :%s/^\\([ ]*>[ ]*\\)*\\(\\|[^>].*\\)$/\\2/g<CR>"
        let savelnum = line(".")
        let lnum = a:firstline
        let lend = a:lastline
        if lnum == lend
                " No visual area choosen --> whole file
                let lnum = line(".")
                let lend = line("$")
                " Go to the begin of the file
                exec "1go"
        endif
        exec ":" . lnum . "," . lend . "s/^[ >]\\+//"
        exec "normal " . savelnum . "G"
endfunction

fu! MailMe()
   %s/^> \(Hallo\|Moin\).*$//e
   %s/ (was:.*)$//e
   g/^> -- \=$/,$d
   g/^> \(Ciao\|Gruss\|Gruesse\|Grüße\|Gruß\|Viele Gr\(u\|ü\)\(ss\|ß\)e\)/,$d
   v/./,//-j
   %s/\s\+$//e
   %s/\(^>\+\)\s\+$/\1/e
   .,$v/^>\+ /s/^\(>\+\)/\1 /e
   :set nohlsearch
   +/^$
endf
map ;ee :sil! :call MailMe()<cr>

" fuck format-flowed!!!111!
function! Fixflowed()
	" save position
	let l = line(".")
	let c = col(".")
	normal G$
	" whiles are used to avoid nasty error messages add spaces to the end of every line
	" between you and me .. i *hate* regexp *narf*
	while search('\([^]> :]\)\n\(>\(> \?\)*[^> ]\)','w') > 0
		s/\([^]> :]\)\n\(>\(> \?\)*[^> ]\)/\1 \r\2/g
	endwhile
	" make sure there's only one space at the end of every line
	while search('\(.* \) \n','w') > 0
		s/\(.* \) \n/\1\r/g
	endwhile
	" now, fix the wockas spacing from the text
	while search('^\([> ]*>\)\([^> ]\)','w') > 0
		s/^\([> ]*>\)\([^> ]\)/\1 \2/
	endwhile
	" now, compress the wockas
	while search('^\(>>*\) \(>>*\( [^>]\)*\)', 'w') > 0
		s/^\(>>*\) \(>>*\( [^>]\)*\)/\1\2/
	endwhile
	" restore the original location, such as it is
	execute l . " normal " . c . "|"
endfunction
