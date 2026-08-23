{ pkgs, inputs, ... }:

let
  vim-tidal = pkgs.vimUtils.buildVimPlugin {
    name = "vim-tidal";
    src = inputs.vim-tidal-src;
  };
in
{

  home.packages = with pkgs; [
    tidal-cycles-full
  ];

  programs.nixvim = {
    extraPlugins = [ vim-tidal ];

    globals = {
      tidal_target = "terminal";
      tidal_ghci = "${pkgs.tidal-cycles-full.ghcWithTidal}/bin/ghci";
      tidal_boot = "${pkgs.tidal-cycles-full.tidalBoot}/share/tidal-cycles/BootTidal.hs";
    };
  };
}
