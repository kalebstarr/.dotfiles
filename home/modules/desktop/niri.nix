{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile = {
    "DankMaterialShell".source = link "${dotfiles}/home/config/dms";

    "niri/dms".source = link "${dotfiles}/home/config/niri/dms";

    "niri/config.kdl".source = ../../config/niri/config.kdl;
  };
}
