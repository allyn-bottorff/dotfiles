{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "allyn.bottorff";
  home.homeDirectory = "/Users/allyn.bottorff";
  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
	pkgs.curl
	pkgs.bat
	pkgs.gh
	pkgs.go
	pkgs.kubernetes-helm
	pkgs.kubectl
	pkgs.eza
	pkgs.colima
	pkgs.entr
	pkgs.fzf
	pkgs.neovim
	pkgs.jq
	pkgs.rustup
	pkgs.dig
	pkgs.step-cli
	pkgs.starship
	pkgs.alacritty
	pkgs.taskwarrior
	pkgs.docker
    pkgs.docker-buildx
    pkgs.docker-compose
	pkgs.texliveMedium
	pkgs.zig
	pkgs.flyctl
	pkgs.yq-go
    pkgs.zellij
    pkgs.fd
    pkgs.zsh-syntax-highlighting
    pkgs.ipcalc
    pkgs.lima-bin
    pkgs.neovide
    pkgs.bacon
    pkgs.ripgrep
    pkgs._1password
    pkgs.qmk
    pkgs.opentofu
    pkgs.glab
    pkgs.tmux
    pkgs.zk
    pkgs.krew
    pkgs.unzip
    # pkgs.gcc
    pkgs.gnumake
    # pkgs.python3
    # pkgs.netcat-openbsd
    pkgs.tart
    # pkgs.ansible
    pkgs.cmake
    pkgs.fossil
    pkgs.bat-extras.batman
    pkgs.jujutsu
    pkgs.luajit
    pkgs.wezterm
    pkgs.fastfetch
    pkgs.tree-sitter
    pkgs.nodejs_22
    # pkgs.darwin.libiconv
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
  };



  nix = {
  package = pkgs.nix;
  settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
