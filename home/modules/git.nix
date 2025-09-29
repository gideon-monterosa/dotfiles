{ config, pkgs, lib, ... }:
{
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
}

