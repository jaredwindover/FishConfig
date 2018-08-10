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