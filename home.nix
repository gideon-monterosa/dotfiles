{ config, pkgs, ... }:

{
  home.username = "gideon";
  home.homeDirectory = "/Users/gideon";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    starship
    fzf

    # neovim config dependencies
    nodejs_latest
    tree-sitter

    # for java development
    openjdk21
  ];

  home.file = {
    ".zshrc".source = ./config/zsh/zshrc;
    ".config/ghostty/config".source = ./config/ghostty/config;
  };

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.openjdk21}/lib/openjdk";
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
    };

    ignores = [
      ".DS_Store"
    ];
  };

  programs.home-manager.enable = true;
}
