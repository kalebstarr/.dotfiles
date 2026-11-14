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

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      nixos-wsl,
      nixos-hardware,
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
            ./hosts/common.nix
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
          ];
        };
    in
    {
      nixosConfigurations.thinkpad = mkHost {
        hostModule = ./hosts/thinkpad;
        homeModule = ./home/laptop.nix;
        extraModules = [ nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen1 ];
      };

      nixosConfigurations.blade = mkHost {
        hostModule = ./hosts/blade;
        homeModule = ./home/laptop.nix;
        extraModules = with nixos-hardware.nixosModules; [
          common-cpu-amd
          common-cpu-amd-pstate
          common-gpu-amd
          common-gpu-nvidia
          common-pc-laptop
          common-pc-laptop-ssd
        ];
      };

      nixosConfigurations.wsl = mkHost {
        hostModule = ./hosts/wsl;
        homeModule = ./home/wsl.nix;
      };
    };

}
