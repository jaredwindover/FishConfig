# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream   'yes'
set __fish_git_prompt_showcolorhints 'yes'

# Status Chars
set __fish_git_prompt_char_dirtystate      '⚡'
set __fish_git_prompt_char_stagedstate     '→'
set __fish_git_prompt_char_stashstate      '↩'
set __fish_git_prompt_char_upstream_ahead  '↑'
set __fish_git_prompt_char_upstream_behind '↓'

# Status Colors
set __fish_git_prompt_color_branch          yellow
set __fish_git_prompt_color_dirtystate      yellow
set __fish_git_prompt_color_stagedstate     blue
set __fish_git_prompt_color_stashstate      yellow

alias ls 'ls -p --color=always'
alias la "ls -Agho | sed 's/\s\+\w\+//1'"
alias p "ping -c 3 www.google.com"

#pacman functions

alias pacman 'pacman --color always'

function ∮pacco -d "get pacman package for function"
	pacman -Qo (which $argv) | \
	sed 's/^.*is owned by[[:space:]]*\([[:graph:]]*\).*/\1/'
end

function ∮pacci -d "get pacman information for function"
	pacman -Qi (∮pacco $argv)
end

function ∮paci -d "get pacman information for package"
	pacman -Qi $argv
end

function ∮pace -d "list packages explicitly installed"
	pacman -Qe
end

function ∮pacg -d "list package groups"
	pacman -Qg       | \
	awk '{print $1}' | \
	sort -u
end

function ∮pacgi -d "get verbose information for group"
	pacman -Qi --color never (pacman -Rscp $argv | \
	sed 's/[.:_-][0-9].*$//')
end

function ∮pacgis -d "get short information for group"
	∮pacgi $argv | \
	grep "^Name\|^Installed Size\|^Description"
end

function ∮pacng -d "get information for explicitly installed things"
	pacman -Qi --color never (pacman -Qeq --color never) | \
	sed -n '/Name\|Groups\|Description/ s/^.*: // p'     | \
	paste -sd ',,\n'                                     | \
	awk -F ',' '{print $3","$1","$2}'                    | \
	sed -n 's/^None,//p'                                 | \
	column -ts ","
end

#function ∮pacng
# pacman -Qi --color never (pacman -Qeq --color never) | \
#	sed -n '/Name\|Groups/ s/^.*: // p'                  | \
#	paste -sd ',\n'                                      | \
#	awk -F ',' '{print $2","$1}'                         | \
#	sed -n 's/^None,//p'
#end

function ∮paco -d "get package owner of file"
	pacman -Qo $argv
end

#function ∮twit -d "command line twitter client"
#	ttytter -ansi -daemon -hold
#	∮wait
#end

#navigation functions

function cl -d "change directory and list contents"
	cd $argv
	la
end

#git functions

function ∮gitd -d "get diff of listed files"
	git diff (git status --porcelain | sed -n '/'$argv[1]'/ {s/^ [A-Z] //p; q}')
end

function ∮gits -d "get git status"
	git status $argv
end

function ∮gitss -d "get short git status"
	git status --short $argv
end

function ∮giti -d "hard to say"
	git diff-tree --no-commit-id --name-only -r $argv
end

#emacs for editing

alias e "emacsclient -n"

function ∮E -d "use existing emacs instance to edit write-protected file"
	begin
		set -lx EDITOR "emacsclient"
		sudo -e $argv
	end
end

#utility

function ∮fuck -d "automatically fix previous command"
	thefuck (history | head -n 1)
end

function ∮wait -d "wait for 1 second"
	while true
		sleep 1000
	end
end

function ∮fresh -d "freshen the fish"
	. ~/.config/fish/config.fish
end

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

function ∮describe -d "list functions in fish file"
	sed -n '
	/^function/ {
	  s/^function\s*\(.*\){/\1/;
		H;
		x;
		p;
	}
	/\/\*.*\*\// !{
	  /\/\*/  h
		/\/\*/ !H
	}' $argv
end

function ∮funclist -d "list functions in fish file"
	sed '
	/^$/ d
	/\/\*/,/\*\// d
	/^\/\// d
	s!//.*!!
	' $argv
end

function ∮prefix -d "hard to say"
	echo $argv[2] | grep '^'$argv[1] >/dev/null ^/dev/null
end

function ∮push -d "push notification to phone"
	curl -s                                               \
	--form-string  "token=atNQrB8CHDfRzbTa5DmpeYybWkXeHL" \
	--form-string  "user=ud1BAyr2T49wC58iK53hHTsfdd5omw"  \
	--form-string  "message="$argv[1]                     \
	https://api.pushover.net/1/messages.json
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
