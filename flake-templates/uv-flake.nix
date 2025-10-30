{
  description = "Development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        libs = with pkgs; [
          openssl
          zlib
          curl
          stdenv.cc.cc
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs =
            with pkgs;
            [
              uv
              python315
            ]
            ++ libs;

          shellHook = ''
            # Use NixOS Python to avoid downloading dynamically-linked binaries
            export UV_PYTHON=${pkgs.python312}/bin/python
            export UV_PYTHON_DOWNLOADS=never

            # Set library path for vendored dependencies (numpy, etc.)
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libs}:$LD_LIBRARY_PATH
          '';
        };
      }
    );
}
