#emacs for editing

alias e "emacsclient -n"

function ∮E -d "use existing emacs instance to edit write-protected file"
	begin
		set -lx EDITOR "emacsclient"
		sudo -e $argv
	end
end
