{ config, ... }:


# nix-channels:
# home-manager https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz
# nixpkgs https://nixos.org/channels/nixos-24.05
# nixpkgs-unstable https://nixos.org/channels/nixpkgs-unstable


let
    pkgs = import <nixpkgs> {
        config.allowUnfree = true;
    };
    pkgsUnstable = import <nixpkgs-unstable> {
        config.allowUnfree = true;
    };
    pkgs_kubectl = import (builtins.fetchGit {
         # Descriptive name to make the store path easier to identify
         name = "kubectl-1.26.3";
         url = "https://github.com/NixOS/nixpkgs/";
         ref = "refs/heads/nixpkgs-24.05-darwin";
         rev = "7ad7b570e96a3fd877e5fb08b843d66a30428f12";
     }) {};
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pay-mbp-abottorff";
  home.homeDirectory = "/Users/pay-mbp-abottorff";
  # nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # pkgs_kubectl.kubectl
    pkgs.kubectl
    pkgs.curl
    pkgs.bat
    pkgs.gh
    pkgs.go
    # pkgs.kubernetes-helm
    pkgs.eza
    pkgs.entr
    pkgs.fzf
    pkgs.neovim
    pkgs.jq
    pkgs.dig
    pkgs.step-cli
    pkgs.docker
    pkgs.docker-buildx
    pkgs.docker-compose
    # pkgs.texliveMedium
    pkgs.zig
    pkgs.yq-go
    pkgs.fd
    pkgs.ripgrep
    # pkgs._1password-cli
    # pkgs.qmk
    # pkgs.opentofu
    # pkgs.glab
    pkgs.tmux
    # pkgs.krew
    pkgs.unzip
    pkgs.uutils-coreutils
    pkgs.gcc
    pkgs.gnumake
    # pkgs.ansible
    pkgs.cmake
    pkgs.bat-extras.batman
    pkgs.luajit
    pkgs.fastfetch
    pkgs.tree-sitter
    # pkgs.nodejs-slim
    pkgs.kind
    pkgs.xplr
    # pkgs.hledger
    # pkgs.nerdctl
    pkgs.delve
    # pkgs.protobuf3_20
    # pkgs.protoc-gen-go
    pkgs.difftastic
    pkgs.btop
    pkgs.tokei
    pkgs.asciidoctor
    pkgs.lima-bin
    pkgs.lua54Packages.luarocks
    pkgs.yazi
    pkgs.azure-cli
    pkgs.fish
    pkgs.jujutsu
    pkgs.darwin.libiconv
    pkgs.git
    pkgs.git-lfs
    pkgs.uv
    pkgs.dust
    pkgs.colima
    pkgs.fx
    # pkgs.zed-editor
    pkgs.gopls
    pkgs.ruff
    pkgs.lua-language-server
    pkgs.typst
    pkgs.zls
    pkgs.awscli2
    pkgs.jaq
    pkgs.watch
    pkgs.zsh-syntax-highlighting
    pkgs.starship
    pkgs.terraform-ls
    pkgs.localstack
    pkgs.zk
    pkgs.helix
    pkgs.copilot-language-server
    pkgs.github-copilot-cli
    pkgs.gemini-cli
    pkgs.ty
    pkgs.rustup
    pkgs.glow
    pkgs.devcontainer
    pkgs.kotlin
    # pkgs.kotlin-native
    pkgs.kotlin-language-server
    pkgs.emacs-macport
    pkgs.neovide

    #Engineering Onboarding Paytient
    pkgs.sops
    pkgs.libxml2
    pkgs.tenv
    pkgs.oras
    pkgs.pgformatter
    pkgs.just
    pkgs.asdf-vm
    pkgs.javaPackages.compiler.temurin-bin.jdk-21

 
    # pkgsUnstable.evil-helix
    # pkgsUnstable.claude-code
    pkgs.atuin
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/allyn/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    ZSH_SYNTAX_HIGHLIGHTING_PATH = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
    FZF_DIR = "${pkgs.fzf}";
    ZSH_ASDF_VM = "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh";
  };



  nix = {
  package = pkgs.nix;
  settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
