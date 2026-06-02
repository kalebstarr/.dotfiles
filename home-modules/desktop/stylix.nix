{ pkgs, ... }:

{

  stylix = {
    enable = true;
    overlays.enable = false;
    image = ../../wallpapers/Sunset.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
    };

    opacity = {
      terminal = 0.9;
      applications = 0.95;
      desktop = 0.95;
      popups = 0.95;
    };

    targets.nixvim.transparentBackground = {
      main = true;
      numberLine = true;
      signColumn = true;
    };
  };

}
