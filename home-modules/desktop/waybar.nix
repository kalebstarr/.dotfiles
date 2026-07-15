{ config, ... }:

let
  colors = config.lib.stylix.colors.withHashtag;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;

      modules-left = [
        "niri/workspaces"
        "niri/window"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "tray"
        "backlight"
        "network"
        "pulseaudio"
        "battery"
      ];

      "niri/workspaces" = {
        format = "{value}";
        all-outputs = true;
      };

      "niri/window" = {
        format = "{}";
        max-length = 60;
        separate-outputs = true;
      };

      clock = {
        format = "{:%H:%M  %d/%m}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar.mode = "month";
      };

      tray = {
        icon-size = 18;
        spacing = 10;
      };

      network = {
        interval = 3;
        format-wifi = "  {essid}";
        format-ethernet = "  {ifname}";
        format-disconnected = "󰖪  Disconnected";
        tooltip-format = "{ifname} via {gwaddr}";
      };

      backlight = {
        format = "{icon} {percent}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
        ];
        on-scroll-up = "swayosd-client --brightness raise";
        on-scroll-down = "swayosd-client --brightness lower";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 Muted";
        format-icons.default = [
          ""
          ""
        ];
        on-click = "pavucontrol";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "FiraCode Nerd Font", "Noto Sans", sans-serif;
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        border-bottom: 2px solid ${colors.base03};
      }

      #workspaces button {
        padding: 0 8px;
        color: ${colors.base04};
      }

      #workspaces button.active {
        color: ${colors.base0D};
        background: ${colors.base02};
      }

      #workspaces button.urgent {
        color: ${colors.base00};
        background: ${colors.base08};
      }

      #window,
      #clock,
      #network,
      #backlight,
      #pulseaudio,
      #tray,
      #battery {
        padding: 0 10px;
      }

      #battery.warning {
        color: ${colors.base0A};
      }

      #battery.critical,
      #network.disconnected {
        color: ${colors.base08};
      }
    '';
  };
}
