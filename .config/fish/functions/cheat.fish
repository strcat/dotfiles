function cheat --description "Pipe cht.sh output to 'bat'"
    curl 2>/dev/null cheat.sh/$argv | bat --style=numbers,grid
end
complete -c cheat -xa '(curl -s cheat.sh/:list)'
