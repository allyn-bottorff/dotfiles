{ config, ... }:

# nix-channels:
# home-manager https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz
# nixpkgs https://nixos.org/channels/nixos-24.05
# nixpkgs-unstable https://nixos.org/channels/nixpkgs-unstable

let
  neovim-nightly-overlay = import (
    builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }
  );
  pkgs = import <nixpkgs> {
    config.allowUnfree = true;
    # config.allowUnfreePredicate =
    #   pkg:
    #   builtins.elem (lib.getName pkg) [
    #     "tart"
    #   ];
    overlays = [ neovim-nightly-overlay ];
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
  }) { };
in
{
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pay-mbp-abottorff";
  home.homeDirectory = "/Users/pay-mbp-abottorff";
  # nixpkgs.config.allowUnfree = true;

  imports =
    [ ]
    ++ (
      let
        p = (builtins.getEnv "HOME") + "/.config/home-manager/paytient.nix";
      in
      if builtins.pathExists p then [ (/. + p) ] else [ ]
    )
    ++ (
      let
        p = (builtins.getEnv "HOME") + "/.config/home-manager/personal.nix";
      in
      if builtins.pathExists p then [ (/. + p) ] else [ ]
    );
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
    # KUBERNETES
    pkgs.kubectl
    pkgs.kind
    # pkgs.kubernetes-helm

    # TOOLS
    pkgs.asciidoctor
    pkgs.awscli2
    pkgs.btop
    pkgs.curl
    pkgs.dig
    pkgs.dust
    pkgs.fastfetch
    pkgs.fd
    pkgs.fx
    pkgs.glow
    pkgs.jaq
    pkgs.jq
    pkgs.step-cli
    pkgs.tmux
    pkgs.typst
    pkgs.unzip
    pkgs.uutils-coreutils
    pkgs.viu
    pkgs.watch
    pkgs.yazi
    pkgs.yq-go
    pkgs.zk

    # REQUIREMENTS
    pkgs.atuin
    pkgs.bat
    pkgs.bat-extras.batman
    pkgs.eza
    pkgs.fish
    pkgs.fzf
    pkgs.git
    pkgs.jujutsu
    pkgs.ripgrep
    pkgs.starship
    pkgs.zsh-syntax-highlighting

    # EDITOR + LANGUAGE SERVERS
    pkgs.copilot-language-server
    pkgs.emacs
    pkgs.gopls
    pkgs.helix
    pkgs.lua-language-server
    pkgs.neovide
    pkgs.neovim
    pkgs.nixfmt
    pkgs.ruff
    pkgs.terraform-ls
    pkgs.tree-sitter
    pkgs.ty
    pkgs.zls

    # DEV TOOLS
    pkgs.cmake
    pkgs.darwin.libiconv
    pkgs.delve
    pkgs.difftastic
    pkgs.entr
    pkgs.gcc
    pkgs.gemini-cli
    pkgs.gh
    pkgs.git-lfs
    pkgs.github-copilot-cli
    pkgs.glibtool
    pkgs.gnumake
    pkgs.go
    pkgs.libtool
    pkgs.rustup
    pkgs.tokei
    pkgs.uv
    pkgs.zig

    # VIRTUALIZATION
    pkgs.colima
    pkgs.devcontainer
    pkgs.docker
    pkgs.docker-buildx
    pkgs.docker-compose
    pkgs.krunkit
    pkgs.podman
    pkgs.podman-compose
    pkgs.podman-tui

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
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
