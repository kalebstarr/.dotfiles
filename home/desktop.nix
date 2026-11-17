{ pkgs, ... }:

{
  imports = [
    ./modules/desktop/niri.nix
    ./modules/desktop/dux.nix
  ];

  home.packages = with pkgs; [
    brave-origin
    obsidian
    discord
    proton-vpn
    papirus-folders

    base16-schemes
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.sessionVariables = {
    PROTON_PASS_LINUX_KEYRING = "dbus";
    USE_BUILTIN_RIPGREP = "0";
  };
}
