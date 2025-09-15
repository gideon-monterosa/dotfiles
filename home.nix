{ config, pkgs, ... }:

{
  home.username = "gideon";
  home.homeDirectory = "/Users/gideon";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    starship
    fzf
    mas
    ripgrep
    pkgs.texlive.combined.scheme-full
    go

    # neovim config dependencies
    nodejs_latest
    tree-sitter
    markdownlint-cli

    # for java development
    openjdk21
    # openjdk17
  ];

  home.file = {
    ".zshrc".source = ./config/zsh/zshrc;
    ".config/ghostty/config".source = ./config/ghostty/config;
  };

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.openjdk21}";
  };

  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    userName = "Gideon Monterosa";
    userEmail = "gideon.monterosa@gmail.com";

    extraConfig = {
      core.editor = "nvim";
      color.ui = "auto";
      push.autoSetupRemote = true;
      credential.helper = "osxkeychain";
    };

    ignores = [
      ".DS_Store"
    ];
  };

  programs.home-manager.enable = true;
}
