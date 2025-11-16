function fzffindedit
  set -l file (
    fzf --no-multi --select-1 --exit-0 \
        --preview 'bat --color=always --line-range :500 {}'
    )
  # double quote is required.
  if test -n "$file" 
    $EDITOR "$file"
  end
  commandline -f repaint
end
