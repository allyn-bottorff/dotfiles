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
alias docker-stahp='docker stop $(docker ps -a -q)'
alias exip='dig @ns1.google.com +short o-o.myaddr.l.google.com txt'
alias fixresolv='~/resolv-ansible/venv/bin/ansible-playbook -K ~/resolv-ansible/add-umbrella.yml'
alias neovide='neovide --multiGrid 1>/dev/null'

# change git origin from gitlab.veteransunited.com to gitlab.redchimney.com
chgitorigin() { git remote set-url origin $(git remote get-url origin | sed 's/veteransunited/redchimney/') }

# LOGZ function

logz() {
  if [[ $1 == "client" ]]
  then
     for i in `kubectl get pods|grep f5api|grep -v schema|awk {'print $1'}`; do echo $i; kubectl logs $i f5api; echo; done;
  elif [[ $1 == "service" ]]
  then
    if [[ -z $2 ]]
    then
      for i in `kubectl get pods|grep svc|awk {'print $1'}`; do j=`echo $i|cut -d"-" -f1-6`;echo $i; kubectl logs $i $j;echo; done
    else
      for i in `kubectl get pods|grep svc|awk {'print $1'}|grep $2`; do j=`echo $i|cut -d"-" -f1-6`;echo $i; kubectl logs $i $j;echo; done
    fi
  fi
  }

logzf() {
  if [[ $1 == "client" ]]
  then
     for i in `kubectl get pods|grep f5api|grep -v schema|awk {'print $1'}`; do echo $i; kubectl logs -f $i f5api; echo; done;
  elif [[ $1 == "service" ]]
  then
    if [[ -z $2 ]]
    then
      for i in `kubectl get pods|grep svc|awk {'print $1'}`; do j=`echo $i|cut -d"-" -f1-6`;echo $i; kubectl logs -f $i $j;echo; done
    else
      for i in `kubectl get pods|grep svc|awk {'print $1'}|grep $2`; do j=`echo $i|cut -d"-" -f1-6`;echo $i; kubectl logs -f $i $j;echo; done
    fi
  fi
  }


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
export KUBECONFIG=~/.kube/rancher-dev:~/.kube/rancher-uat:~/.kube/rancher-prod:~/.kube/hedraios:~/.kube/rancher-infra:~/.kube/hashistack-test:~/.kube/rancher-prod-kdc:~/.kube/kdc-dev:~/.kube/kdc-uat
#export SHELL="/usr/sbin/zsh"

#export KUBECTX_IGNORE_FZF=1
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

#Named Directories
hash -d code=/Users/Allyn.Bottorff/Documents/code


# Fix for PIP MITM while on VU network
HOME_NET='10.46'
ifconfig | grep $HOME_NET > /dev/null
GREP_RC=$?
if test $GREP_RC -ne 0
then
        export REQUESTS_CA_BUNDLE='/Users/Allyn.Bottorff/Cisco_Umbrella_Root_CA.cer'
fi

#for ansible:
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

source <(kubectl completion zsh)

# Colors (doesn't work on a mac. no dircolors)
# eval `gdircolors ~/.dircolors-solarized/dircolors-solarized/dircolors.ansi-dark`
source ~/.dircolors-solarized/zsh-dircolors-solarized.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fortune -s | cowsay

# pipenv settings
#export PATH="$PATH:/Users/Allyn.Bottorff/Library/Python/3.9/bin"
#export PIPENV_VENV_IN_PROJECT=1

# Kubectl Krew
export PATH="${PATH}:${HOME}/.krew/bin"

#minio auto-complete
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc

source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#eval "$(starship init zsh)"


