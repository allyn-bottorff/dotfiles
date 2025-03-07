if status is-interactive
    # Commands to run in interactive sessions can go here

    fish_vi_key_bindings

    abbr -a -- l eza -lhF --git
    abbr -a -- cat bat
    abbr -a -- vim nvim
    abbr -a -- k kubectl
    abbr -a -- krc kubectl resource-capacity

    set -Ux EDITOR "nvim"
    set -Ux SHELL "fish"
    set -Ux KUBECONFIG "$HOME/.kube/config-prod:$HOME/.kube/config-non-prod:$HOME/.kube/config-test"
    set -Ux GITLAB_HOST "https://gitlab.redchimney.com"

    set -gx PATH $HOME/.cargo/bin $PATH
    set -gx PATH $HOME/.krew/bin $PATH

    COMPLETE=fish jj | source


    starship init fish | source
end



