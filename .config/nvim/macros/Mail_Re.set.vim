"===============================================================
" VIM script file.
"
" File          : Mail_Re.set
" Author        : Dominique Baldo
" Updated by	: Luc Hermitte <hermitte@free.fr>
"                 <URL:http://hermitte.free.fr/vim/>
" Version	: 1.2
" Last update   : 28th july 2001
"
"---------------------------------------------------------------
" Purpose	: Merge the occurencies of "Re:" and "Re[n]" within
" 		  e-mails'subject in only one.
"
" Calling conv.	: Source this file and invoke Mail_Re(). Other solution :
" 		  define -> map ,re :call Mail_Re()<cr>
"
"---------------------------------------------------------------
" Updates	: 
"   * ver 1.2	: translation of the comments
"   * ver 1.1	: Handle "RÈf" produced by some french e-mailers
"		  Answer by "Re:" most of the time
"   * ver 1.0	: Replace "Re: Re: ..." n times by "Re[n]:"
"
" TODO		:
"   * Simplify the operations like for instance, the way "Re:" occurences
"     are counted.
"   * Enable to customize the string returned : currently, MergeRe(str)
"     returns "Re[n]:" if there where a similar construct in the initial
"     string, or "Re:" otherwise.
"
"===============================================================

"
"
"===============================================================
" Function	: MergeRe(string)
" Purpose	: Substitute "Re:Re:Re:Re" by "Re:" and "Re:Re[2]" by "Re[3]"
func! MergeRe(string)
 " We retrieve  the "real" subjet (discarding of all the "Re:")
   " But first, we replace all the "RÈf.:" by "Re:" and erase spaces between
   " "Re:"
   let subject = substitute( a:string, '[Rr][Èe…E][fF]\s*\.\s*:\s*', 'Re:', 'g' )
   let subject = substitute( subject, '[Rr][eE]\s*\(\[\d\+\]\)\=\s*:\s*', 'Re\1:', 'g' )
   " We search for the first "Re:"
   let rank=matchend(subject,'Subject:\s*Re:\s*')
   " If none, it means we have finished
   if rank==-1
      return subject
   endif
   " n: "Re:" counter
   let n=0
   " Where there are "Re:" to discard ...
   " TODO: extract "\(Re:)*" and get the length...
   while rank!=-1
     " We discard them one by one (in order to count them) ...
     let subject=strpart(subject,rank,strlen(subject))
     " ... and we search the next one that "starts the line".
     let rank=matchend(subject,'^Re:\s*')
     let n=n+1       
   endw
   
   " Once at the end, we check for the presence of a "Re[x]:"
   let num=matchstr(subject,'^[Rr][Ee]\s*\[\s*[0-9]\+\s*\]\s*:\s*')
   let rank=matchend(subject,'^[Rr][Ee]\s*\[\s*[0-9]\+\s*\]\s*:\s*')
   " If there were one: 
   " 		 [TODO] define an option to customize the desired behaviour
   if num!=""
      " We extract the number x from "Re[x]" ...
      let num=matchstr(num,'[0-9]\+')
      " ... and add it to n (the number of "Re:")
      let n = n + num
      " And we don't forget to discard "Re[x]:" from the subject
      let subject=strpart(subject,rank,strlen(subject)+1)
      let subject = 'Subject: Re[' . n . ']: ' . subject 
   else
      let subject = 'Subject: Re: ' .subject
   endif

   " Finally, we return the new subject 
   return subject
endf

""""""""""""""""""""""""""""""
"   M A I N   P R O G R A M  "
""""""""""""""""""""""""""""""

function! Mail_Re()
  " Find the subject
  normal 1G
  /^Subject: 
  " Get the corresponding line
  let c=getline(line("."))
  " And call MergeRe() on it.
  call setline(line("."),MergeRe(c))
endf

