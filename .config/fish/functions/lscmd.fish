function lscmd --description "List command by name"
	if test (count $argv) -ne 1
		echo "Usage: lscmd command"
		return 1
	end

	set -l cmd $argv[1]

	for path in $PATH
		if test -d $path
			fd ".*$cmd.*" -l -t x -t f $path
		end
	end
end
