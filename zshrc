# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
# End Nix
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
setopt extendedglob
setopt inc_append_history_time
setopt GLOB_COMPLETE
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey '^r' history-incremental-pattern-search-backward

# ALIASES

alias vim='nvim'
alias l='eza -lhF --git'
alias k='kubectl'
alias cat='bat'
alias bangcopy='op read op://work/bang/password | pbcopy'
alias ssh='TERM=xterm-256color ssh'
alias weather="curl 'wttr.in/columbia+missouri?1'"

export EDITOR='nvim'
export ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"
export GITLAB_HOST=https://gitlab.redchimney.com

export KUBECONFIG=~/.kube/config-prod:~/.kube/config-non-prod

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

### FZF

source $(fzf-share)/completion.zsh
source $(fzf-share)/key-bindings.zsh


source <(kubectl completion zsh)

eval "$(starship init zsh)"
source $ZSH_SYNTAX_HIGHLIGHTING_PATH


