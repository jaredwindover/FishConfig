#docker

function ∮dockex -d "execute given docker"
	docker exec -it $argv /bin/bash
end

function parse -d "provide default value for bash variable"
	if test -z $argv[1]
		if test -z $argv[2]
			return 1
		else
			echo $argv[2]
		end
	else
		echo $argv[1]
	end
end

function ∮dock -d "kill existing dockers, delete their images, and re run"
	set name (parse $argv[1] app)
	set dir (parse $argv[2] .)
	set port (parse $argv[3] 8081)
	if set -q argv[4]
		set rest $argv[4..-1]
	end
	set cmd docker run -d -p $port:80 --name $name $rest $name
	docker kill $name ^&- >&-
	or echo $name" not running"
	docker rm $name ^&- >&-
	or echo "No image "$name
	docker build -t $name $dir
	and eval $cmd
end

function ∮map -d "create docker file mapping"
	set h $argv[1]
	set t $argv[2]
	set r ''
	for p in $argv[3..-1]
		set r $r -v $h/$p:$t/$p
	end
	echo $r
end
