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
