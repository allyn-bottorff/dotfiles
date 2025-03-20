if status is-interactive
    # Commands to run in interactive sessions can go here

    fish_vi_key_bindings

    abbr -a -- l eza -lhF --git
    abbr -a -- cat bat
    abbr -a -- vim nvim
    abbr -a -- k kubectl
    abbr -a -- krc kubectl resource-capacity
    abbr -a -- ssh TERM=xterm-256color ssh
    abbr -a -- pe petools-cli

    set -Ux EDITOR "nvim"
    set -Ux SHELL "fish"
    set -Ux KUBECONFIG "$HOME/.kube/config-prod:$HOME/.kube/config-non-prod:$HOME/.kube/config-test"
    set -Ux GITLAB_HOST "https://gitlab.redchimney.com"
    set -Ux LIBRARY_PATH "$HOME/.nix-profile/lib:$LIBRARY_PATH"

    set -gx PATH $HOME/.cargo/bin $PATH
    set -gx PATH $HOME/.krew/bin $PATH
    set -gx PATH $HOME/.local/bin $PATH

    COMPLETE=fish jj | source

    source $(fzf-share)/key-bindings.fish


    starship init fish | source
end



