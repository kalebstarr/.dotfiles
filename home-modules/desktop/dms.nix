{
  config,
  lib,
  pkgs,
  ...
}:

let
  # DMS owns these writable files after first use. Rebuilds preserve GUI edits.
  settings = {
    currentThemeName = "dynamic";
    currentThemeCategory = "dynamic";
    fontFamily = "DejaVu Sans";
    monoFontFamily = "FiraCode Nerd Font";
    # DMS uses a 14px baseline; 10pt at 96 DPI is approximately 13.33px.
    fontScale = 0.95238;
    cursorSettings = {
      theme = "System Default";
      size = 24;
      niri = {
        hideWhenTyping = false;
        hideAfterInactiveMs = 0;
      };
    };
    barConfigs = [
      {
        id = "default";
        name = "Main Bar";
        enabled = true;
        position = 0;
        screenPreferences = [ "all" ];
        showOnLastDisplay = true;
        leftWidgets = [
          "launcherButton"
          "workspaceSwitcher"
          "focusedWindow"
        ];
        centerWidgets = [ "clock" ];
        rightWidgets = [
          "systemTray"
          "notificationButton"
          "battery"
          "controlCenterButton"
        ];
        autoHide = false;
        visible = true;
      }
    ];
    clockDateFormat = "ddd, dd.MM.";
    showBatteryPercent = true;
    showBatteryPercentOnlyOnBattery = false;
    notificationPopupPosition = 0; # Top right.
    soundNewNotification = false;
    notificationHistoryEnabled = true;
    notificationHistoryMaxCount = 50;
    notificationHistoryMaxAgeDays = 7;
    lockScreenNotificationMode = 1; # Count only.
    lockPamPath = "/etc/pam.d/dms";
    lockPamExternallyManaged = true;
    lockBeforeSuspend = true;
    loginctlLockIntegration = true;
    acLockTimeout = 900;
    batteryLockTimeout = 900;
    acMonitorTimeout = 1200;
    batteryMonitorTimeout = 1200;
    acSuspendTimeout = 0;
    batterySuspendTimeout = 0;
    # Keep the requested timeouts exact, without an additional fade grace period.
    fadeToLockEnabled = false;
    fadeToDpmsEnabled = false;
    runDmsMatugenTemplates = true;
    matugenTemplateGtk = true;
    matugenTemplateNiri = true;
    matugenTemplateGhostty = true;
    matugenTemplateDgop = true;
    matugenTemplateHyprland = false;
    matugenTemplateMangowc = false;
    matugenTemplateQt5ct = false;
    matugenTemplateQt6ct = false;
    matugenTemplateFcitx5 = false;
    matugenTemplateQtengine = false;
    matugenTemplateFirefox = false;
    matugenTemplatePywalfox = false;
    matugenTemplateZenBrowser = false;
    matugenTemplateVesktop = false;
    matugenTemplateVencord = false;
    matugenTemplateEquibop = false;
    matugenTemplateKitty = false;
    matugenTemplateFoot = false;
    matugenTemplateAlacritty = false;
    matugenTemplateNeovim = false;
    matugenTemplateWezterm = false;
    matugenTemplateKcolorscheme = false;
    matugenTemplateVscode = false;
    matugenTemplateEmacs = false;
    matugenTemplateZed = false;
  };
  session = {
    isLightMode = false;
    wallpaperPath = toString ../../wallpapers/Sunset.png;
    wallpaperCyclingEnabled = false;
    terminalOverride = "ghostty";
  };
  clipboard = {
    disabled = false;
    maxHistory = 100;
    autoClearDays = 7;
    clearAtStartup = false;
  };
  seed = destination: source: ''
    if [ ! -e ${lib.escapeShellArg destination} ] && [ ! -L ${lib.escapeShellArg destination} ]; then
      run install -D -m 600 ${source} ${lib.escapeShellArg destination}
    fi
  '';
  seedJson =
    destination: value: seed destination (pkgs.writeText "dms-initial.json" (builtins.toJSON value));
  cfg = config.xdg.configHome;
  searchRoots =
    with config.xdg.userDirs;
    [
      documents
      download
      pictures
      music
      videos
    ]
    ++ [ "${config.home.homeDirectory}/Code" ];
in
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    pictures = "${config.home.homeDirectory}/Pictures";
    music = "${config.home.homeDirectory}/Music";
    videos = "${config.home.homeDirectory}/Videos";
  };

  home.activation.dmsInitialSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] (
    seedJson "${cfg}/DankMaterialShell/settings.json" settings
    + seedJson "${config.xdg.stateHome}/DankMaterialShell/session.json" session
    + seedJson "${cfg}/DankMaterialShell/clsettings.json" clipboard
    # Ghostty can start before the first matugen run. This writable fallback is
    # replaced by DMS; Home Manager must never symlink its generated theme.
    + seed "${cfg}/ghostty/themes/dankcolors" (
      pkgs.writeText "ghostty-initial-theme" ''
        background = 1a1b26
        foreground = c0caf5
        cursor-color = c0caf5
        selection-background = 283457
        selection-foreground = c0caf5
      ''
    )
  );

  xdg.configFile."danksearch/config.toml".source =
    (pkgs.formats.toml { }).generate "danksearch-config.toml"
      {
        index_all_files = true;
        text_extensions = [ ];
        index_xattr_tags = false;
        index_paths = map (path: {
          inherit path;
          max_depth = 0; # Unlimited.
          exclude_hidden = true;
          merge_default_exclude_dirs = true;
          extract_exif = false;
          extract_xattr_tags = false;
          watch = true;
        }) searchRoots;
      };

  # HM owns the CSS imports/font baseline; matugen owns dank-colors.css.
  gtk = {
    enable = true;
    gtk3.extraCss = ''@import url("dank-colors.css");'';
    gtk4.extraCss = ''@import url("dank-colors.css");'';
    font = {
      name = "DejaVu Sans";
      package = pkgs.dejavu_fonts;
      size = 12;
    };
  };
  dconf.settings."org/gnome/desktop/interface" = {
    font-name = "DejaVu Sans 12";
    document-font-name = "DejaVu Serif 12";
    monospace-font-name = "FiraCode Nerd Font 12";
  };
  home.packages = [ pkgs.adw-gtk3 ];
}
