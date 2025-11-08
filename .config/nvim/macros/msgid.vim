" Step 1: Search for "^Message-ID:"
" Step 2: Message-ID exist => Do nothing
" Step 3: Message-ID not exist => create and add one (See strftime(3) for details)
"--------------------------------------------------
" function GenerateMessageID() 
"         let l:fqdn = "painless.my-fqdn.de"
"         let l:id = "Message-ID: <".strftime("%Y-%m-%dT%H-%M-%S")."@".l:fqdn.">"
"         return l:id
" endfunction
" function InsertMessageID() 
"         let l:id = GenerateMessageID()
"         execute "normal! 1G}i".l:id."\n\<Esc>"
" endfunction
" function FindMessageID()
"         let l:line = search("^[Mm][Ee][Ss][Ss][Aa][Gg][Ee]-[Ii][Dd]","bW")
"         return l:line
"  endfunction
" execute "normal! 1G" 
" execute "normal! ".search("^$","W")."G" 
" if FindMessageID() == 0
"   call InsertMessageID()
" endif
"-------------------------------------------------- 

" The same again but now a "X-Now-Playing:"
function GenerateNowPlaying()
	"let l:id = "X-Now-Playing: ".system("cat /home/dope/.now_playing")
	let l:id = "X-Now-Playing: ".system("/home/dope/bin/now-playing.sh | sed 's/^np: //g'")
        return l:id
endfunction
function InsertNowPlaying()
        let l:id = GenerateNowPlaying()
        execute "normal! 1G}i".l:id."\<Esc>"
endfunction
function FindNowPlaying()
        let l:line = search("^X-Now-Playing:","bW")
        return l:line
 endfunction
execute "normal! 1G" 
execute "normal! ".search("^$","W")."G" 
if FindNowPlaying() == 0
  call InsertNowPlaying()
endif
