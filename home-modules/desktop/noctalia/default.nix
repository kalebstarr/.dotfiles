{ config, lib, pkgs, ... }:

let
  settings = builtins.fromJSON (builtins.readFile ./settings.json);
  colors = config.lib.stylix.colors.withHashtag;
  themedSettings = lib.recursiveUpdate settings {
    bar.backgroundOpacity = config.stylix.opacity.terminal;
    colorSchemes = {
      useWallpaperColors = false;
      predefinedScheme = "";
      darkMode = true;
    };
    ui = {
      fontDefault = config.stylix.fonts.sansSerif.name;
      fontFixed = config.stylix.fonts.monospace.name;
      panelBackgroundOpacity = config.stylix.opacity.terminal;
    };
  };
  themedColors = {
    mPrimary = colors.base0C;
    mOnPrimary = colors.base00;
    mSecondary = colors.base0E;
    mOnSecondary = colors.base00;
    mTertiary = colors.base0B;
    mOnTertiary = colors.base00;
    mError = colors.base09;
    mOnError = colors.base00;
    mSurface = colors.base00;
    mOnSurface = colors.base08;
    mSurfaceVariant = colors.base01;
    mOnSurfaceVariant = colors.base05;
    mOutline = colors.base02;
    mShadow = colors.base00;
    mHover = colors.base0C;
    mOnHover = colors.base00;
  };
  json = pkgs.formats.json { };
in

{
  home.packages =
    with pkgs;
    [
      quickshell
    ]
    ++ lib.optionals (pkgs ? noctalia-shell) [
      pkgs.noctalia-shell
    ];

  xdg.configFile."noctalia/settings.json".source =
    json.generate "noctalia-settings.json" themedSettings;

  xdg.configFile."noctalia/colors.json".source =
    json.generate "noctalia-colors.json" themedColors;
}
