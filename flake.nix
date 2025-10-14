{

  description = "NixOS ThinkPad";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-config = {
      url = "github:kalebstarr/nvim-config";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nvim-config,
      ...
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kaleb = import ./home.nix;
              extraSpecialArgs = { inherit nvim-config; };
            };
          }
        ];
      };
    };

}
