{ lib, pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
      quickshell
    ]
    ++ lib.optionals (pkgs ? noctalia-shell) [
      pkgs.noctalia-shell
    ];

  xdg.configFile."noctalia/settings.json".source = ./settings.json;
}
