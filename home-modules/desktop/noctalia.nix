{ ... }:

{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      settingsVersion = 0;
      bar = {
        barType = "simple";
        position = "top";
        density = "default";
        showOutline = false;
        showCapsule = true;
        widgetSpacing = 6;
        contentPadding = 2;
        enableExclusionZoneInset = true;
        marginVertical = 4;
        marginHorizontal = 4;
        outerCorners = true;
        displayMode = "always_visible";
        widgets = {
          left = [
            { id = "Launcher"; }
            { id = "Clock"; }
            { id = "ActiveWindow"; }
          ];
          center = [
            { id = "Workspace"; }
          ];
          right = [
            { id = "Tray"; }
            { id = "Battery"; }
            { id = "Volume"; }
            { id = "Brightness"; }
            { id = "ControlCenter"; }
          ];
        };
        mouseWheelAction = "none";
        middleClickAction = "none";
        rightClickAction = "controlCenter";
      };
      general = {
        showScreenCorners = false;
        animationSpeed = 1;
        animationDisabled = false;
        language = "";
        showChangelogOnStartup = false;
        telemetryEnabled = false;
        clockStyle = "custom";
        clockFormat = "hh:mm";
        reverseScroll = false;
        smoothScrollEnabled = true;
      };
      ui = {
        tooltipsEnabled = true;
        scrollbarAlwaysVisible = true;
        boxBorderEnabled = false;
        translucentWidgets = false;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
      };
      location = {
        weatherEnabled = false;
        weatherShowEffects = false;
        autoLocate = false;
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
        showCalendarEvents = false;
        showCalendarWeather = false;
      };
      dock = {
        enabled = false;
      };
      notifications = {
        enabled = true;
      };
      launcher = {
        enabled = true;
      };
      osd = {
        enabled = true;
      };
    };
  };
}
