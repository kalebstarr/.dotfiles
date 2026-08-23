{ pkgs, ... }:

{

  home.packages = with pkgs; [
    tidal-cycles-full
  ];

  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.vim-tidal ];

    globals = {
      tidal_target = "terminal"; # native nvim terminal, no tmux
      tidal_ghci = "${pkgs.tidal-cycles-full.ghcWithTidal}/bin/ghci";
      tidal_boot = "${pkgs.tidal-cycles-full.tidalBoot}/share/tidal-cycles/BootTidal.hs";
      maplocalleader = ",";
    };
  };

}
