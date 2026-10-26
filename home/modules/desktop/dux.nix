{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile = {
    "dms".source = link "${dotfiles}/home/config/dms";
    "dsearch".source = link "${dotfiles}/home/config/dsearch";
  };

}
