{ inputs, ... }:

{
  imports = [
    ./common.nix
    ../home-modules/desktop/stylix.nix
    inputs.stylix.homeModules.stylix
  ];
}
