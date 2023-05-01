# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

#autoload -Uz compinit
#compinit
# End of lines added by compinstall

# third party completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi
setopt GLOB_COMPLETE
bindkey '^r' history-incremental-pattern-search-backward

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select

CASE_SENSITIVE="true"

setopt inc_append_history_time

# ALIASES
alias vim='nvim'
alias l='exa -lhF --git'
alias exip='dig @ns1.google.com +short o-o.myaddr.l.google.com txt'
alias neovide='neovide --multigrid 1>/dev/null'
#alias neovide='open -b com.neovide.neovide'
alias k='kubectl'
alias cat='bat'

# change git origin from gitlab.veteransunited.com to gitlab.redchimney.com
#chgitorigin() { git remote set-url origin $(git remote get-url origin | sed 's/veteransunited/redchimney/') }

# LOGZ function

# PROMPT

#autoload -Uz vcs_info
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
#setopt prompt_subst
#zstyle ':vcs_info:git*' formats '<%r - %b>'

#source ~/.git-prompt.sh
##source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
#source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
#setopt PROMPT_SUBST ; RPROMPT='$(__git_ps1 " (%s)")$(kube_ps1)'

##NEWLINE=$'\n'
#PS1="%F{brwhite}[%f%F{blue}allyn%f%F{brwhite}@%f%F{green}%m%f%F{brwhite}]$(kube_ps1)[%f%F{blue}%~%f%F{brwhite}]%f%F{brwhite}%%%f "
##PS1='$(kube_ps1)'$PS1


#title
# if [[ $TERM == xterm-termite ]]; then
#     . /etc/profile.d/vte.sh
#     __vte_osc7
# fi

export XDG_CONFIG_HOME="/Users/Allyn.Bottorff/.config/"

export EDITOR=nvim
export KUBECONFIG=~/.kube/ch3-dev.yaml:~/.kube/ch3-uat.yaml:~/.kube/ch3-prod.yaml:~/.kube/da11-prod.yaml:~/.kube/da11-dev.yaml:~/.kube/da11-uat.yaml:~/.kube/primary-dmz-backend.yaml:~/.kube/primary-dmz.yaml:~/.kube/da11-dev-lan.yaml:~/.kube/ch3-prod-lan.yaml
#export SHELL="/usr/sbin/zsh"

#export KUBECTX_IGNORE_FZF=1
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

export NEOVIDE_MULTIGRID=1

export GITLAB_HOST=https://gitlab.redchimney.com



# Fix for PIP MITM while on VU network
#HOME_NET='10.46'
#ifconfig | grep $HOME_NET > /dev/null
#GREP_RC=$?
#if test $GREP_RC -ne 0
#then
#        export REQUESTS_CA_BUNDLE='/Users/Allyn.Bottorff/Cisco_Umbrella_Root_CA.cer'
#fi

#for ansible:
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

source <(kubectl completion zsh)

# Colors (doesn't work on a mac. no dircolors)
# eval `gdircolors ~/.dircolors-solarized/dircolors-solarized/dircolors.ansi-dark`
#source ~/.dircolors-solarized/zsh-dircolors-solarized.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fortune -s | cowsay

# pipenv settings
#export PATH="$PATH:/Users/Allyn.Bottorff/Library/Python/3.9/bin"
#export PIPENV_VENV_IN_PROJECT=1

# Kubectl Krew
export PATH="${PATH}:${HOME}/.krew/bin"
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/.cargo/bin"

# NVM GARBAGE
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#minio auto-complete
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc

#source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#eval "$(starship init zsh)"


export PATH="/opt/homebrew/opt/curl/bin:$PATH"

eval "$(starship init zsh)"

complete -o nospace -C /opt/homebrew/bin/terraform terraform

complete -o nospace -C /opt/homebrew/bin/mc mc
