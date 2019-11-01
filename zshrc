# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/allyn/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey '^r' history-incremental-pattern-search-backward

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ALIASES

alias vim='nvim'
alias l='ls -lh'
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'
alias docker-stahp='sudo docker stop $(docker ps -a -q)'

# PROMPT

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git*' formats '<%r - %b>'

source ~/.git-prompt.sh
setopt PROMPT_SUBST ; RPROMPT='$(__git_ps1 " (%s)")'

PS1='%F{brwhite}[%f%F{blue}%n%f%F{brwhite}@%f%F{green}%m%f%F{brwhite}][%f%F{blue}%~%f%F{brwhite}]%f%F{brwhite}%%%f '

# Colors
eval `dircolors ~/.dircolors-solarized/dircolors.ansi-dark`




source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
