function multicd --description "navigate to parent directories based on the number of dots in the args"
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
