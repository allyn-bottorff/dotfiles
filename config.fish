
if status is-interactive
    # Commands to run in interactive sessions can go here
    alias l="eza -lhF --git"
    alias vim="nvim"
    alias k="kubectl"
    alias cat="bat"

    set -Ux EDITOR "nvim"
    set -Ux SHELL "fish"
    set -Ux KUBECONFIG "$HOME/.kube/config-prod:$HOME/.kube/config-non-prod:$HOME/.kube/config-test"
    set -Ux GITLAB_HOST "https://gitlab.redchimney.com"

    set -gx PATH $HOME/.cargo/bin $PATH
    set -gx PATH $HOME/.krew/bin $PATH


    starship init fish | source
end



