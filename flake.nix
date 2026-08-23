{

  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-doom-emacs-unstraightened = {
    #   url = "github:marienz/nix-doom-emacs-unstraightened";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    vim-tidal-src = {
      url = "github:tidalcycles/vim-tidal";
      flake = false;
    };

  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      nixos-wsl,
      stylix,
      nixos-hardware,
      # nix-doom-emacs-unstraightened,
      ...
    }@inputs:
    let
      mkHost =
        {
          hostModule,
          homeModule,
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            hostModule
            ./modules/common.nix
          ]
          ++ extraModules
          ++ [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kaleb = import homeModule;
                extraSpecialArgs = { inherit inputs; };
                backupFileExtension = "backup";
              };
            }
            stylix.nixosModules.stylix
          ];
        };
    in
    {
      nixosConfigurations.thinkpad = mkHost {
        hostModule = ./hosts/thinkpad;
        homeModule = ./home/thinkpad.nix;
        extraModules = [ nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen1 ];
      };

      nixosConfigurations.wsl = mkHost {
        hostModule = ./hosts/wsl;
        homeModule = ./home/wsl.nix;
      };
    };

}
