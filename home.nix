{ config, pkgs, ... }:

{
  home.username = "gideon";
  home.homeDirectory = "/Users/gideon";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    starship
    fzf
  ];

  home.file = {
    ".zshrc".source = ./config/zsh/zshrc;
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
