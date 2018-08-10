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

function newBranch -d "create a new branch using a template"
		git checkout -b 'jwindover_'(date "+%Y-%m-%d")_(echo "$argv" | sed "s/ /-/g")
end

function archive -d "archive a git branch"
		git tag archive/$argv $argv
		git branch -d $argv
end

alias nb 'newBranch'
