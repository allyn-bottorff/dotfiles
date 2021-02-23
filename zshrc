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

# ALIASES
alias alacritty='open -n /Applications/Alacritty.app'
alias vim='nvim'
alias l='gls -lhF --color=auto'
alias docker-stahp='docker stop $(docker ps -a -q)'
alias exip='dig @ns1.google.com +short o-o.myaddr.l.google.com txt'
alias fixresolv='~/resolv-ansible/venv/bin/ansible-playbook -K ~/resolv-ansible/add-umbrella.yml'

# PROMPT

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git*' formats '<%r - %b>'

source ~/.git-prompt.sh
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
setopt PROMPT_SUBST ; RPROMPT='$(__git_ps1 " (%s)")$(kube_ps1)'

#NEWLINE=$'\n'
PS1="%F{brwhite}[%f%F{blue}allyn%f%F{brwhite}@%f%F{green}%m%f%F{brwhite}]$(kube_ps1)[%f%F{blue}%~%f%F{brwhite}]%f%F{brwhite}%%%f "
#PS1='$(kube_ps1)'$PS1


#title
# if [[ $TERM == xterm-termite ]]; then
#     . /etc/profile.d/vte.sh
#     __vte_osc7
# fi

export XDG_CONFIG_HOME="/Users/Allyn.Bottorff/.config/"

export EDITOR="/usr/local/bin/nvim"
export KUBECONFIG=~/.kube/rancher-dev:~/.kube/rancher-uat:~/.kube/rancher-prod:~/.kube/hedraios
#export SHELL="/usr/sbin/zsh"

#export KUBECTX_IGNORE_FZF=1

#for ansible:
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

source <(kubectl completion zsh)

# Colors (doesn't work on a mac. no dircolors)
# eval `gdircolors ~/.dircolors-solarized/dircolors-solarized/dircolors.ansi-dark`
source ~/.dircolors-solarized/zsh-dircolors-solarized.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fortune | cowsay

source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#eval "$(starship init zsh)"

