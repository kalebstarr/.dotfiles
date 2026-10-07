{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile = {
    "DankMaterialShell".source = link "${dotfiles}/home/config/dms";
    "danksearch".source = link "${dotfiles}/home/config/danksearch";
  };

}
