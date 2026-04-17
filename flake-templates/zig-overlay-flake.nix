{
  description = "Development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      zig-overlay,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        zig = zig-overlay.packages.${system}."0.16.0";
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            zig
            pkgs.zls
          ];

          shellHook = ''
            export ZIG_GLOBAL_CACHE_DIR="$PWD/.zig-cache"
          '';
        };
      }
    );
}
