{
  description = "Gideon's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {
      system.primaryUser = "gideon";

      environment.systemPackages = [
        pkgs.neovim
      ];

      homebrew = {
        enable = true;
	casks = [
	  "arc"
	  "ghostty"
	];
	onActivation.cleanup = "zap";
	onActivation.autoUpdate = true;
	onActivation.upgrade = true;
      };

      nix.settings.experimental-features = "nix-command flakes";

      system = {
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 6;

        defaults = {
          dock = {
            autohide = true;
            tilesize = 48;
          };
        };

        keyboard = {
	  enableKeyMapping = true;
	  remapCapsLockToControl = true;
	};
      };

      nixpkgs.hostPlatform = "x86_64-darwin";
      nixpkgs.config.allowUnfree = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Gideons-MacBook-Pro
    darwinConfigurations."Gideons-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
	nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "gideon";
          };
        }
      ];
    };
  };
}
