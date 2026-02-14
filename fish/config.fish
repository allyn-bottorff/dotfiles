if status is-interactive
    # Commands to run in interactive sessions can go here

    fish_vi_key_bindings

    abbr -a -- l eza -lhF
    abbr -a -- cat bat
    abbr -a -- vim nvim
    abbr -a -- k kubectl
    # abbr -a -- krc kubectl resource-capacity
    # abbr -a -- ssh TERM=xterm-256color ssh
    abbr -a -- nix-garbage nix-collect-garbage --delete-old
    abbr -a -- emc emacsclient -c
    
    abbr -a -- oc "$HOME/code/paytient/opencode/start"

    set -Ux EDITOR "nvim"
    set -Ux --path KUBECONFIG "$HOME/.kube/config"
    set -gx SHELL "fish"
    set -Ux --path LIBRARY_PATH "$HOME/.nix-profile/lib"

    set -gx PATH $HOME/.local/bin $PATH
    set -gx PATH $HOME/go/bin $PATH
    set -gx PATH /nix/var/nix/profiles/default/bin $PATH
    set -gx PATH $HOME/.nix-profile/bin $PATH
    set -gx PATH $HOME/.cargo/bin $PATH
    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx GITHUB_PAT $(cat $HOME/temp/github_package_pull_token)
    set -gx DD_API_KEY $(cat $HOME/temp/dd_api_key)
    set -gx DD_APP_KEY $(cat $HOME/temp/dd_app_key)

    set -gx NIX_PROFILES /nix/var/nix/profiles/default /Users/pay-mbp-abottorff/.nix-profile
    set -gx NIX_SSL_CERT_FILE /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt
    set -gx SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt

    # COMPLETE=fish jj | source

    # Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'


    # source $(fzf-share)/key-bindings.fish
    atuin init fish --disable-up-arrow | source


    # starship init fish | source
end



