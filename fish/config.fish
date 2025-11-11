if status is-interactive
    # Commands to run in interactive sessions can go here

    fish_vi_key_bindings

    abbr -a -- l eza -lhF --git
    abbr -a -- cat bat
    abbr -a -- vim nvim
    # abbr -a -- k kubectl
    # abbr -a -- krc kubectl resource-capacity
    # abbr -a -- ssh TERM=xterm-256color ssh
    
    abbr -a -- opencode "$HOME/code/paytient/opencode/start"

    set -Ux EDITOR "nvim"
    set -Ux SHELL "fish"
    set -Ux --path LIBRARY_PATH "$HOME/.nix-profile/lib"

    set -gx PATH $HOME/.cargo/bin $PATH
    set -gx PATH $HOME/.local/bin $PATH
    set -gx PATH $HOME/go/bin $PATH
    set -gx PATH /nix/var/nix/profiles/default/bin $PATH
    set -gx PATH $HOME/.nix-profile/bin $PATH

    set -gx NIX_PROFILES /nix/var/nix/profiles/default /Users/pay-mbp-abottorff/.nix-profile
    set -gx NIX_SSL_CERT_FILE /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt

    # COMPLETE=fish jj | source


    source $(fzf-share)/key-bindings.fish


    # starship init fish | source
end



