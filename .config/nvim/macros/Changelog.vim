" $Id: Changelog.vim,v 1.1 2003/07/22 16:34:38 dope Exp dope $
"
" Author  : Christian Schneider <strcat@gmx.net>
" Structure of this file:
" Lines starting with an inverted comma (") are comments.
" Some mappings are commented out.  Remove the comment to enable them. (duh)
"
" VIM allows to give special characters by writing them in a special notation.
" The notation encloses decriptive words in angle brackets (<>).
" Read all about it with ":help <>".
" The characters you will most often are:
" <C-M> for control-m
" <C-V> for control-v which quotes the following character
" <ESC> for the escape character.
" All control characters have been replaced to use the angle notation
" so you should be able to read this filw without problems.
" (OK, I left some tabs [control-i] in the file. ;-)
"
" Last modified: [ 2004-02-21 18:37:31 ]

"ChangeLog entry convenience
fun! InsertChangeLog()
    normal(1G)
    call append(0, strftime("%a %b %d %T %Z %Y") . "  Christian Schneider <strcat@gmx.net>")
    call append(1, "")
    call append(2, "  * ")
    call append(3, "")
    execute ':3'
    normal($)
endfun
map ,cl :call InsertChangeLog()<cr>A


"--------------------------------------------------
" " ChangeLog-related features (home-made)
" augroup changelog
"   au!
"   " Insert date, time and email and get ready for a new entry
"   function ChangeLogInsertDate ()
"     normal 1GO
"     call setline (".", strftime ("%Y-%m-%d") . "  Christian Schneider <strcat@gmx.net>")
"     normal o
"     normal o
"     call setline (".", "\<Tab>* ")
"     normal o
"     normal k$
"     startinsert
"   endfunction
"
"   " Just insert a new entry at the end of the first entry block
"   function ChangeLogInsertEntry ()
"     normal 1G2}O
"     call setline (".", "\<Tab>* ")
"     normal $
"     startinsert
"   endfunction
"
"   " Checks whether we need to insert a brand new line or not (non-empty file)
"   function ChangeLogCheckAndInsert ()
"     normal 1GO
"     call setline (1, strftime ("%Y-%m-%d") . "  Christian Schneider <strcat@gmx.net>")
"     let line_to_insert = getline (1)
"     let line_there = getline (2)
"
"     if line_to_insert == line_there
"       " Just add a new entry
"       normal 1Gdd2}O
"     else
"       " Insert new date and name
"       normal 1Go
"       normal 2o
"       normal k
"     endif
"
"     " Add a new entry and start inserting
"     call setline (".", "\<Tab>* ")
"     normal $
"     startinsert
"   endfunction
"--------------------------------------------------
