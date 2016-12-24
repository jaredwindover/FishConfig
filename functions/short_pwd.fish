function line --description 'repeat a set of characters'
	set c $argv[1]
	set n $argv[2]
	head -c $n /dev/zero | sed 's/\x0/'$c'/g'
end

function longest_common_prefix
	set a $argv[1]
	set b $argv[2]
	echo $b | grep -o (echo $a | sed 's/\(.\)/\\\\(\1/g')(line \\\\\?\\\\\) (math (echo $a | wc -m) - 1))
end

function shortest_unique_prefix
	begin
		set check $argv[1]
		set rest $argv[2..-1]1
		set result 1
		set length (math (echo $check | wc -m) - 1)
		set suffix (line '\\\\\?\\\\\)' $length)
		set compare (echo $check | sed 's/\(.\)/\\\\(\1/g')$suffix
		for x in $rest
			set cur (echo $x | grep -o $compare | wc -m)
			if math $cur' > '$result > \dev\null
				set result $cur
			end
		end
		echo $check | head -c $result
	end
end

function short_pwd --description 'print current directory short, suitable for prompt'
	begin
		set d (pwd)
		set h ~
		set mpwd '/'
		if echo $d | grep '^'$h > /dev/null
			set sofar ~
			set mpwd '~/'
			set rest (echo $d | sed 's|^'$h'\/\?||' | sed 's;^/;;'| sed 's|/|\n|g')
			echo $rest | wc -m 1>&2
			for x in $rest
				set test (echo $sofar'/'*/ | sed 's;\(^\| \)'$sofar'/\('$x'/\)\?;\1\n;g')
				set sofar $sofar'/'$x
				set p (shortest_unique_prefix $x $test)
				set mpwd $mpwd$p'/'
			end
		else
			set sofar '/'
			set rest (echo $d | sed 's;\(^/\)\|\(\s*$\);;'| sed 's|/|\n|g')
			echo $rest | wc -m 1>&2
			for x in $rest
				set test (echo $sofar'/'*/ | sed 's;\(^\| \)'$sofar'/\('$x'/\)\?;\1\n;g')
				set sofar $sofar'/'$x
				set p (shortest_unique_prefix $x $test)
				set mpwd $mpwd$p'/'
			end
		end
		echo $mpwd
	end
end
