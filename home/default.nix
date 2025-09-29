{ config, pkgs, ... }:

{
  imports = import ./modules;

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

  programs.home-manager.enable = true;
}
