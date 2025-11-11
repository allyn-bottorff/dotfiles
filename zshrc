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
setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt extendedglob
setopt inc_append_history_time
setopt GLOB_COMPLETE
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit

# comand line editing
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

compinit
# End of lines added by compinstall

bindkey '^r' history-incremental-pattern-search-backward

# ALIASES

alias vim='nvim'
alias l='eza -lhF --git'
alias k='kubectl'
alias cat='bat'
# alias ssh='TERM=xterm-256color ssh'
alias weather="curl 'wttr.in/columbia+missouri?1'"

alias copilot="github-copilot-cli"

alias opencode="$HOME/code/paytient/opencode/start"

export EDITOR='nvim'

# export KUBECONFIG=~/.kube/config-prod:~/.kube/config-non-prod

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export LIBRARY_PATH="$HOME/.nix-profile/lib"

### FZF

source $(fzf-share)/completion.zsh
source $(fzf-share)/key-bindings.zsh


# source <(kubectl completion zsh)

# source <(jj util completion zsh)
source <(COMPLETE=zsh jj)

# Paytient AWS functions
source "$HOME/code/builds/onboarding/engineering.sh"

# AWS CLI Completion
source "$HOME/.nix-profile/bin/aws_zsh_completer.sh"

eval "$(starship init zsh)"

source $ZSH_ASDF_VM


source $ZSH_SYNTAX_HIGHLIGHTING_PATH
