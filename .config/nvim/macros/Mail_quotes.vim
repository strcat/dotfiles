"=============================================================================
" File:		Mail_quotes.vim
" Author:	Brian Medley <EMAIL:freesoftware at 4321.tv> {{{
" 		This file is copy paste only, of Brian operator pending stuff
" 		for e-mail editing.
" 		For practical and personal reasons, I (Luc Hermitte) have
" 		extracted Brian code to this file. It is not meant to be
" 		distributed.
"		Luc Hermitte <EMAIL:hermitte at free.fr>
"		<URL:http://hermitte.free.fr/vim>
"		}}}
" Version:	1
" Created:	05th aug 2002
" Last Update:	02nd dec 2002
"------------------------------------------------------------------------
" Description:	Quote handling stuff
" 
"------------------------------------------------------------------------
" Installation:	$$/ftplugin/mail
" History:	Original version : Brian script on sourceforge
" TODO:		«missing features»
"=============================================================================
" Buffer relative definitions {{{
"------------------------------------------------------------------------
" Avoid reinclusion {{{
if exists('b:loaded_ftplug_Mail_pending_vim') | finish | endif
let b:loaded_ftplug_Mail_pending_vim = 1
" }}}
let s:cpo_save=&cpo
set cpo&vim

if !exists('maplocalleader') || '' == maplocalleader
  let maplocalleader = '\' " Default is »,«
endif
"------------------------------------------------------------------------
" Help {{{
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
"
" Load functions helpfull for Display help messages
" We will use "quote" as prefix
if exists("*BuildHelp") " {{{
  command! -buffer -nargs=1 QHelp :call BuildHelp("quote", <q-args>)
else
  command! -buffer -nargs=1 QHelp
endif " }}}
"  }}}
"------------------------------------------------------------------------
" Mappings {{{
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
" Different mappings {{{
if !hasmapto('<Plug>MailFormatQuote', 'n')
  nmap <silent> <buffer> <unique> <LocalLeader>fmq <Plug>MailFormatQuote
  QHelp |[ n  ]    ,fmq  = 'ForMat Quote' - reformat the current quote level
endif
if !hasmapto('<Plug>MailFormatLine', 'n')
  nmap <silent> <buffer> <unique> <LocalLeader>fml <Plug>MailFormatLine
  QHelp |[ n  ]    ,fml  = 'ForMat Line'  - reformat the current line
endif
if !hasmapto('<Plug>MailFormatMerge', 'n')
  nmap <silent> <buffer> <unique> <LocalLeader>fmm <Plug>MailFormatMerge
  QHelp |[ n  ]    ,fmm  = 'ForMat Merge' - 
endif
if !hasmapto('<Plug>MailFormatParagraph', 'n')
  nmap <silent> <buffer> <unique> <LocalLeader>fmp <Plug>MailFormatParagraph
  QHelp |[ n  ]    ,fmp  = 'ForMat Paragraph'  - reformat the current paragraph
endif
nnoremap <buffer> <unique> <script> <Plug>MailFormatQuote     <SID>FormatQuote
nnoremap <buffer> <unique> <script> <Plug>MailFormatLine      <SID>FormatLine
nnoremap <buffer> <unique> <script> <Plug>MailFormatMerge     <SID>FormatMerge
nnoremap <buffer> <unique> <script> <Plug>MailFormatParagraph <SID>FormatPar

if !hasmapto('<Plug>MailFormatQuote', 'n')
  imap <silent> <buffer> <unique> <C-X>fq <Plug>MailFormatQuote
endif
if !hasmapto('<Plug>MailFormatLine', 'n')
  imap <silent> <buffer> <unique> <C-X>fl <Plug>MailFormatLine
endif
if !hasmapto('<Plug>MailFormatMerge', 'n')
  imap <silent> <buffer> <unique> <C-X>fm <Plug>MailFormatMerge
endif
if !hasmapto('<Plug>MailFormatParagraph', 'n')
  imap <silent> <buffer> <unique> <C-X>fp <Plug>MailFormatParagraph
endif
inoremap <buffer> <unique> <script> <Plug>MailFormatQuote     <SID>FormatQuote
inoremap <buffer> <unique> <script> <Plug>MailFormatLine      <SID>FormatLine
inoremap <buffer> <unique> <script> <Plug>MailFormatMerge     <SID>FormatMerge
inoremap <buffer> <unique> <script> <Plug>MailFormatParagraph <SID>FormatPar

nnoremap <buffer> <script> <SID>FormatQuote     gq<SID>QuoteMotion1j
nnoremap <buffer>          <SID>FormatLine      gqqj
nnoremap <buffer>          <SID>FormatMerge     kgqj
nnoremap <buffer>          <SID>FormatPar       gqap
inoremap <buffer> <script> <SID>FormatQuote     <ESC>gq<SID>QuoteMotion1ji
inoremap <buffer>          <SID>FormatLine      <ESC>gqqji
inoremap <buffer>          <SID>FormatMerge     <ESC>kgqji
inoremap <buffer>          <SID>FormatPar       <ESC>gqapi
" Different mappings }}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
" Mangled Merge {{{
if !hasmapto('<Plug>MailQuoteMangledMerge', 'n')
  nmap <silent> <buffer> <unique> <LocalLeader>qmm <Plug>MailQuoteMangledMerge
  QHelp |[ nv ]    ,qmm  = 'Quote Mangled Merge' - reformat badly quoted paragraph
endif
nnoremap <buffer> <unique> <script> <Plug>MailQuoteMangledMerge 
      \ <SID>QuoteMangledMerge
nnoremap <buffer> <SID>QuoteMangledMerge :.,.+1call <SID>QuoteMangledMerge()<cr>

if !hasmapto('<Plug>MailQuoteMangledMerge', 'v')
  vmap <silent> <buffer> <unique> <LocalLeader>qmm <Plug>MailQuoteMangledMerge
endif
vnoremap <buffer> <unique> <script> <Plug>MailQuoteMangledMerge 
      \ <SID>QuoteMangledMerge
vnoremap <buffer> <SID>QuoteMangledMerge :call <SID>QuoteMangledMerge()<cr>
" Mangle Merge }}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
" Motion {{{
" Provide a motion operator for commands (so you can delete a quote
" segment, or format quoted segment)
if !hasmapto('<Plug>MailQuoteMotion1', 'o')
"  ounmap q
  omap <silent> <buffer> <unique> q <Plug>MailQuoteMotion1
  QHelp |[   o]    q    = {motion} == end of quote level (type 1)
endif
onoremap <buffer> <unique> <script> <Plug>MailQuoteMotion1 <SID>QuoteMotion1
onoremap <buffer> <script> <SID>QuoteMotion1 
      \ :execute "normal!" . <SID>QuoteMotion(line("."), "mail_quote_motion1")<cr>

if hasmapto('<Plug>MailQuoteMotion2', 'o')
  ounmap Q
  omap <silent> <unique> Q <Plug>MailQuoteMotion2
  QHelp |[   o]    o    = {motion} == end of quote level (type 2)
endif
onoremap <buffer> <unique> <script> <Plug>MailQuoteMotion2 <SID>QuoteMotion2
onoremap <buffer> <script> <SID>QuoteMotion2 
      \ :execute "normal!" . <SID>QuoteMotion(line("."), "mail_quote_motion2")<cr>

if hasmapto('<Plug>MailQuoteMotion3', 'o')
  omap <silent> <unique> x <Plug>MailQuoteMotion3
  QHelp |[   o]    x    = {motion} == end of quote level (type 3)
endif
onoremap <buffer> <unique> <script> <Plug>MailQuoteMotion3 <SID>QuoteMotion3
onoremap <buffer> <script> <SID>QuoteMotion3 
      \ :execute "normal!" . <SID>QuoteMotion(line("."), "mail_quote_motion3")<cr>
" Motion }}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
" Del empty quoted lines {{{
if !hasmapto('<Plug>MailQuoteDelEmpty', 'n')
  nmap <silent> <buffer> <unique> ,cqel <Plug>MailQuoteDelEmpty
endif
nnoremap <buffer> <unique> <script> <Plug>MailQuoteDelEmpty <SID>QuoteDelEmpty
nnoremap <buffer> <SID>QuoteDelEmpty :let l=line('.')\|%call <SID>QuoteDelEmpty()\|exe l<cr>

if !hasmapto('<Plug>MailQuoteDelEmpty', 'v')
  vmap <silent> <buffer> <unique> ,cqel <Plug>MailQuoteDelEmpty
endif
vnoremap <buffer> <unique> <script> <Plug>MailQuoteDelEmpty <SID>QuoteDelEmpty
vnoremap <buffer> <SID>QuoteDelEmpty :call <SID>QuoteDelEmpty()<CR>
" Del empty quoted lines }}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
" Quote Fix up Spaces {{{
if !hasmapto('<Plug>MailQuoteFixupSpaces', 'n')
  nmap <silent> <buffer> <unique> <LocalLeader>qfs <Plug>MailQuoteFixupSpaces
  QHelp |[ nv ]    ,qfs = Fixup Spaces
endif
nnoremap <buffer> <unique> <script> <Plug>MailQuoteFixupSpaces
      \ <SID>QuoteFixupSpaces
nnoremap <buffer> <SID>QuoteFixupSpaces 
      \ :call <SID>QuoteFixupSpaces("quote_motion1")<cr>

if !hasmapto('<Plug>MailQuoteFixupSpaces', 'v')
  vmap <silent> <buffer> <unique> <LocalLeader>qfs <Plug>MailQuoteFixupSpaces
endif
vnoremap <buffer> <unique> <script> <Plug>MailQuoteFixupSpaces 
      \ <SID>QuoteFixupSpaces
vnoremap <buffer> <SID>QuoteFixupSpaces 
      \:call <SID>QuoteFixupSpaces("visual")<cr>
" Quote Fix up Spaces }}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
" Remove Depth {{{
if !hasmapto('<Plug>MailQuoteRemoveDpth', 'n')
  nmap <silent> <buffer> <unique> <LocalLeader>qrd <Plug>MailQuoteRemoveDpth
  QHelp |[ nv ]    ,qrd = Remove Depth
endif
nnoremap <buffer> <unique> <script> <Plug>MailQuoteRemoveDpth 
      \ <SID>QuoteRemoveDpth
nnoremap <buffer> <SID>QuoteRemoveDpth 
      \ :call <SID>QuoteRemoveDpth("quote_motion1")<cr>

if !hasmapto('<Plug>MailQuoteRemoveDpth', 'v')
  vmap <silent> <buffer> <unique> <LocalLeader>qrd <Plug>MailQuoteRemoveDpth
endif
vnoremap <buffer> <unique> <script> <Plug>MailQuoteRemoveDpth 
      \ <SID>QuoteRemoveDpth
vnoremap <buffer> <SID>QuoteRemoveDpth 
      \ :call <SID>QuoteRemoveDpth("visual")<cr>
" Remove Depth }}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
" Mappings }}}
"------------------------------------------------------------------------
" }}}
"=============================================================================
" Global definitions -- like functions {{{
"------------------------------------------------------------------------
" Reinclusion stuff {{{
if exists("g:loaded_Mail_pending_vim") 
  let &cpo=s:cpo_save
  finish 
endif
let g:loaded_Mail_pending_vim = 1
" }}}
"------------------------------------------------------------------------
" Internal Variables {{{
" Function: s:SetVar() to global or default {{{
function! s:SetVar(var,default)
  if exists('g:'.a:var)
    let s:{a:var} = g:{a:var}
  else
    " doing :exe to dequote a:default
    exe "let s:{a:var} =".a:default
  endif
endfunction
command! -nargs=+ SetVar :call <sid>SetVar(<f-args>)
" }}}

SetVar quote_chars '|>}#%'
SetVar my_indent_char '>'
" This re defines a 'quote'

if exists ("g:mail_quote_mark_re")
  let s:quote_mark_re = g:mail_quote_mark_re
else
  " Start
  let s:quote_mark_re = '\%('

  " we don't care about people's websites or where to get files
  let s:quote_mark_re = s:quote_mark_re . '\%(http:\|ftp:\|scp:\|news:\)\@!'

  " sometimes there are pesky smiley's on a line
  let s:quote_mark_re = s:quote_mark_re . '\%(:[\-\^]\?[][)(><}{|/DP]\)\@!'

  " some ppl put initals in the quotes
  let s:quote_mark_re = s:quote_mark_re . '\w\{-,4}'

  " actual quote chars
  let s:quote_mark_re = s:quote_mark_re . '[' . s:quote_chars . ']'

  " Ignore long "runs" of quote_chars.  This is to avoid "separators" in
  " email: e.g.
  "
  "   > ################### begin excerpt ###################
  "   > blah blah blah
  "   > ################### end excerpt   ###################
  let s:quote_mark_re = s:quote_mark_re . '\%([' . s:quote_chars . ']\{4,}\)\@!'

  " some ppl put whitespace in the quote, and others don't.
  let s:quote_mark_re = s:quote_mark_re . '\s\?'

  " End
  let s:quote_mark_re = s:quote_mark_re . '\)'
endif

let s:quote_block_re = '^' . s:quote_mark_re . '\+'

" Allow the user to specify how their quote motions operate
SetVar mail_quote_motion1 "inc_or_dec"
SetVar mail_quote_motion2 "dec"
SetVar mail_quote_motion3 "inc"
delcommand SetVar
" Internal Variables }}}
"------------------------------------------------------------------------
" Paragraph Mangling {{{
" Description: {{{
" This routine will try and make sense out of 'Mangled' quoted paragraph.
" For example, it will try and turn :
" > > starting to look like a distro problem... Anyone
" > else
" > > having this problem running a different distro
" > besides
" > > LinuxBlast 8? Anyone tried 8.1 yet?
"
" into:
" > > starting to look like a distro problem... Anyone else
" > > having this problem running a different distro besides
" > > LinuxBlast 8? Anyone tried 8.1 yet?
"
" NOTE: It does *not* reformat like 'gq'.  It only tries to merge a series of
" alternating quote levels.
"
" Definition:
" - Mangled line - It takes two lines to makeup one mangled line.  There will
"   be a quoting level difference between the two.  The second line must have
"   a smaller quoting level than the first to be considered mangled.
"
" Assumptions:
" - It will *always* be called on the line that we want to merge
"   onto.  E.g.:
"
"   > i eat   <<<<< called from here (i.e. a:firstline will be this line)
"   apples
"
" - The user will supply the range to operate over.
" }}}
function s:QuoteMangledMerge() range
  " make sure starting line is sensible
  if a:firstline == line("$") || a:firstline == a:lastline
    return
  endif

  " make sure we have something to work with
  let qfirst = s:QuoteGetDpth(a:firstline)
  if 0 == qfirst | return | endif

  " This loop:
  " - assumes that the current line is what the lines below will merge onto
  let cur = a:firstline
  let next = cur + 1
  let lastline = a:lastline
  while cur < line("$") && cur < lastline
    let qlcur  = s:QuoteGetDpth(cur)
    let qlnext = s:QuoteGetDpth(next)

    " make sure our definition of mangled isn't invalidated
    if qlcur <= qlnext
      let cur  = cur + 1
      let next = cur + 1
      continue
    endif

    " remove the quotes on the merged line
    let newline = getline(next)
    let newline = substitute(newline, s:quote_block_re, '', '')

    " we only do *basic* extra formatting
    if -1 == match(newline, '^\s') && -1 == match(getline(cur), '\s$')
      let newline = " " . newline
    endif

    " merge the lines
    call setline(cur, (getline(cur) . newline))
    exe next . "," . next "normal! dd"

    " we don't increase cur here b/c there might be more lines to merge
    " into cur
    let lastline = lastline - 1
  endwhile
endfunction
" Paragraph Mangling }}}
"------------------------------------------------------------------------
" Quote Motion {{{
" Description: {{{
" This routine will output a motion command that operatates over a quote
" segment.  It is possible to dictate how the routine knows when a quote
" segment stops.  This is by passing in an argument suitable for use by
" s:QuoteGetDpth.
"
" This makes it possible to perform vi commands on quotes.
" E.g:
"   dq  => delete an entire quote section
"   gqq => format an entire quote section
" }}}
function s:QuoteMotion(line, chg)
  if "dec" != a:chg && "inc_or_dec" != a:chg && "inc" != a:chg
    exe "let chg = s:" . a:chg
  else
    let chg = a:chg
  endif

  let len = s:QuoteLenSgmt(a:line, chg)
  if 0 == len | return 0 | endif

  " the 'V' makes the motion linewise
  if 1 == len
    return "V" . line(".") . "G"
  else
    return "V" . (len - 1) . "j"
  endif
endfunction
" Quote Motion }}}
"------------------------------------------------------------------------
" Quote Len Sgmt {{{
" Description: {{{
" This tries to figure out how long a particular quote segment lasts.  It is
" possible to dictate how the routine knows when a quote segment stops.  This
" is done by passing in an argument suitable for use by s:QuoteGetDpth.
"
" E.g.:
"   % ab> apple        <<< called here
"   % ab> two
"   % ab> orange
"   % ab> > NO!
"   %
"   % yeah, I agree
"
"   will return 3 if passed
" }}}
function s:QuoteLenSgmt(start, chg)
  let depth = s:QuoteGetDpth(a:start)

  let i = a:start + 1
  let len = 1

  " find end of quote
  while i <= line('$')
    if "inc_or_dec" == a:chg
      if depth != s:QuoteGetDpth(i)
	break
      endif
    elseif "inc" == a:chg
      if depth < s:QuoteGetDpth(i)
	break
      endif
    elseif "dec" == a:chg
      if depth > s:QuoteGetDpth(i)
	break
      endif
    endif

    let i   = i   + 1
    let len = len + 1
  endwhile

  return len
endfunction
" Quote Len Sgmt }}}
"------------------------------------------------------------------------
" Quote Get Dpth {{{
" Description: {{{
" This routine will try and return the quote depth for a particular line.
"
" e.g.: (the return value for this routine is in ())
" (3) > > ab% hi bob
" (3) > > ab% i hate you
" (2) > > :) I hate myself
" }}}
function s:QuoteGetDpth(line)
  let string = getline(a:line)

  if "" == string | return 0 | endif

  let quote_depth = 0
  let quote = '^' . s:quote_mark_re
  while -1 != match(string, quote)
    let quote_depth = quote_depth + 1
    let string = substitute(string, quote, '', '')
  endwhile

  return quote_depth
endfunction
" Quote Get Dpth }}}
"------------------------------------------------------------------------
" Del Empty quoted lines {{{
" Description: {{{
" Replace empty quoted lines (e.g. "> ab% ") with empty lines (convenient to
" automatically reformat one paragraph).
"
" This routine is a bit more complicated than necessary.  This is so that the
" headers won't be deleted (if the user includes ':' in quote_chars).
"
" TODO: make this function to not move the cursor
" }}}
function s:QuoteDelEmpty() range
  let empty_quote  = s:quote_block_re . '\s*$'
  let whole_buffer = (1 == a:firstline) && (line("$") == a:lastline)

  "
  " make sure we never operate on headers
  "
  normal gg
  if 0 == search('^$', 'W')
    " if there are no headers, then they aren't really a problem...
    let end_headers = a:firstline
  else
    let end_headers = line(".")
  endif

  " this checks to see if we were called on the header portion of the email.
  " headers are a problem if the user has ':' in s:quote_chars.
  "
  " however, if the user wants the whole buffer to operate on we'll ignore
  " the starting position
  if a:firstline < end_headers && !whole_buffer
    " restore starting position
    exe "normal! " . a:firstline . 'gg'
    return
  endif

  " start search at most sensible place
  if whole_buffer
    exe "normal! " . end_headers . 'gg'
  else
    exe "normal! " . a:firstline . 'gg'
  endif

  let line = line(".")
  while line <= a:lastline
    if -1 != match (getline(line), empty_quote)
      let newline = substitute(getline(line), empty_quote, '', '')
      call setline(line, newline)
    endif
    let line = line + 1
  endwhile

  " restore starting position
  exe "normal! " . a:firstline . 'gg'
endfunction
"------------------------------------------------------------------------
let &cpo=s:cpo_save
" }}}
"------------------------------------------------------------------------
" Quote Fixup Spaces {{{
" Description: {{{
" This routine will turn all quotes that don't have spaces into ones that do.
"
" It is possible to specify when the quote fixation will stop.  This is
" possible in two ways.  The first is by using a visual range of 2 or more
" lines.  The second is by calling this routine with a range of 1 line (e.g.
" from normal mode) and passing in an argument for QuoteLenSgmt.
" }}}
function s:QuoteFixupSpaces(chg) range
  let line = a:firstline
  let first_quote = '^' . s:quote_mark_re

  " figure out our quote segment length
  if a:firstline == a:lastline
    let len = s:QuoteLenSgmt (line, a:chg)
    if 0 == len | return | endif
  else
    let len = a:lastline - a:firstline + 1
  endif

  while 0 < len
    let quote_block = matchstr(getline(line), s:quote_block_re)
    if "" == quote_block
      next
    endif

    " parse through all the quote_marks and add spaces as necessary
    let new_quote_block = ""
    let change = "no"
    while -1 != match(quote_block, first_quote)
      let quote_mark  = matchstr(quote_block, first_quote)
      let quote_block = substitute(quote_block, first_quote, '', '')
      if -1 != match(quote_mark, '\s$')
	let new_quote_block = new_quote_block . quote_mark
      else
	let new_quote_block = new_quote_block . quote_mark . " "
	let change = "yes"
      endif
    endwhile

    " put our new quote_block in
    if "yes" == change
      let newline = substitute(getline(line), s:quote_block_re, '', '')
      call setline (line, (new_quote_block . newline))
    endif

    let line = line + 1
    let len  = len  - 1
  endwhile
endfunction
" }}}
"------------------------------------------------------------------------
" Remove Depth {{{
" Description: {{{
" This routine will try and decrease the quote depth of a quote segment by
" one.  However, it will remove the *last* layer of quoting.  This is b/c it
" is assumed that the user wants the *oldest* quote to be gone.
"
" It is possible to specify when the quote removal will stop.  This is
" possible in two ways.  The first is by using a visual range of 2 or more
" lines.  The second is by calling this routine with a range of 1 line (e.g.
" from normal mode) and passing in an argument for QuoteLenSgmt.
"
" e.g. (if we were passed "inc_or_dec" in chg):
"   ab> % > I really
"   ab> % > like
"   ab> % > apples
"   ab> % > > yup
"   ab> % hello
"
"   ab> % lala
"
" will become :
"   ab> % I really
"   ab> % like
"   ab> % apples
"   ab> % > > yup
"   ab> % hello
"
"   ab> % lala
" }}}
function s:QuoteRemoveDpth(chg) range
  let line         = a:firstline
  let remove_quote = s:quote_mark_re . '$'

  " figure out our quote segment length
  if a:firstline == a:lastline
    let len = s:QuoteLenSgmt (line, a:chg)
    if 0 == len | return | endif
  else
    let len = a:lastline - a:firstline + 1
  endif

  while 0 < len
    " first we whip of the oldest quote_mark from the quote_block
    let newquote = matchstr(getline(line), s:quote_block_re)
    let newquote = substitute(newquote, remove_quote, '', '')

    " then we remove the old quote_block and add on the new one
    let newline = substitute(getline(line), s:quote_block_re, '', '')
    let newline = newquote . newline
    call setline(line, newline)

    let line = line + 1
    let len  = len  - 1
  endwhile
endfunction
" }}}
"------------------------------------------------------------------------
" }}}
"=============================================================================
" vim600: set fdm=marker:
