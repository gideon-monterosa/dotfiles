{
  description = "Gideon's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
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
	  "1password"
	  "scroll-reverser"
	  "docker-desktop"
	  "intellij-idea"
	  "visual-studio-code"
	  "microsoft-teams"
	  "microsoft-outlook"
	  "microsoft-powerpoint"
	  "fujifilm-x-raw-studio"
	  "shottr"
	];
	masApps = {
	  "Xcode" = 497799835;
	};
	onActivation.cleanup = "zap";
	onActivation.autoUpdate = true;
	onActivation.upgrade = true;
      };

      nix.settings.experimental-features = "nix-command flakes";
      
      users.users.gideon.home = "/Users/gideon";

      system = {
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 6;

        defaults = {
	  finder = {
	    FXPreferredViewStyle = "Nlsv";
	  };

          dock = {
            autohide = true;
            tilesize = 48;

            persistent-apps = [
	      "/Applications/Arc.app"
	      "/Applications/Ghostty.app"
	      "/Applications/Microsoft Teams.app"
	      "/Applications/Microsoft Outlook.app"
	    ];
          };

	  trackpad = {
	    TrackpadThreeFingerDrag = true;
	  };
	
	  NSGlobalDomain = {
	    NSAutomaticInlinePredictionEnabled = false;
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
    # darwin-rebuild build --flake .#Gideons-MacBook-Pro
    # or the following alias if it has been built before:
    # switch
    darwinConfigurations."Gideons-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
	nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            user = "gideon";
          };
        }
	home-manager.darwinModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.gideon = import ./home;
	}
      ];
    };
  };
}
