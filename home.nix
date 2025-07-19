{ config, pkgs, ... }:

{
  home.username = "gideon";
  home.homeDirectory = "/Users/gideon";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    starship
    fzf
  ];

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    
    shellAliases = {
    };

    history = {
      size = 5000;
      path = "${config.home.homeDirectory}/.zsh_history";
      save = 5000;
      ignoreSpace = true;
      ignoreDups = true;
      ignoreAllDups = true;
      share = true;
    };

    initContent = ''
      autoload -Uz compinit && compinit
      eval "$(starship init zsh)"
      eval "$(fzf --zsh)"

      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
    '';
  };
}
