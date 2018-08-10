function ∮fresh -d "freshen the fish"
	source ~/.config/fish/config.fish
end

function safeSource -d "source a file if it's present"
		[ -f $argv ]; and source $argv
end

function sourceRelative -d "source a file relative to the current directory"
		safeSource (status filename | sed "s|/[^/]*\$||")"/$argv"
end

sourceRelative "./modules/prompt.fish"
sourceRelative "./modules/navigation.fish"
sourceRelative "./modules/emacs.fish"
sourceRelative "./modules/git.fish"
sourceRelative "./modules/pacman.fish"
sourceRelative "./modules/docker.fish"
sourceRelative "./modules/path.fish"

alias ls 'ls -p'
alias la "ls -Agho | sed 's/\s\+\w\+//1'"
alias p "ping -c 3 www.google.com"

safeSource /usr/local/share/autojump/autojump.fish
