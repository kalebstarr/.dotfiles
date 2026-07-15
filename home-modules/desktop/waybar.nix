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
      height = 38;
      margin-top = 8;
      margin-left = 10;
      margin-right = 10;
      spacing = 8;

      modules-left = [
        "custom/launcher"
        "niri/workspaces"
        "niri/window"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "idle_inhibitor"
        "tray"
        "backlight"
        "network"
        "pulseaudio"
        "battery"
      ];

      "custom/launcher" = {
        format = "";
        on-click = "fuzzel";
        tooltip = false;
      };

      "niri/workspaces" = {
        format = "{value}";
        all-outputs = true;
      };

      "niri/window" = {
        format = "{title}";
        max-length = 50;
        separate-outputs = true;
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󰅶";
          deactivated = "󰾪";
        };
        tooltip-format-activated = "Idle lock disabled";
        tooltip-format-deactivated = "Idle lock enabled";
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
        font-family: "FiraCode Nerd Font", "Noto Sans", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: ${colors.base05};
      }

      .modules-left,
      .modules-center,
      .modules-right {
        background: alpha(${colors.base00}, 0.92);
        border: 1px solid ${colors.base03};
        border-radius: 12px;
        padding: 2px 8px;
      }

      tooltip {
        background: alpha(${colors.base00}, 0.96);
        border: 1px solid ${colors.base0D};
        border-radius: 10px;
      }

      tooltip label {
        color: ${colors.base05};
        padding: 6px;
      }

      button {
        border-radius: 8px;
        box-shadow: none;
        text-shadow: none;
        transition: background-color 150ms ease, color 150ms ease;
      }

      #custom-launcher {
        color: ${colors.base0D};
        font-size: 18px;
        padding: 0 10px 0 6px;
      }

      #workspaces {
        margin: 2px 0;
      }

      #workspaces button {
        min-width: 24px;
        padding: 0 6px;
        color: ${colors.base04};
        background: transparent;
      }

      #workspaces button.active {
        color: ${colors.base07};
        background: ${colors.base02};
      }

      #workspaces button:hover {
        color: ${colors.base0D};
        background: alpha(${colors.base02}, 0.7);
      }

      #workspaces button.urgent {
        color: ${colors.base00};
        background: ${colors.base0F};
      }

      #window {
        color: ${colors.base04};
        font-style: italic;
        padding: 0 12px;
      }

      #clock {
        color: ${colors.base0D};
        font-weight: bold;
        padding: 0 12px;
      }

      #idle_inhibitor,
      #network,
      #backlight,
      #pulseaudio,
      #tray,
      #battery {
        padding: 0 7px;
      }

      #idle_inhibitor.activated {
        color: ${colors.base0A};
      }

      #battery.charging,
      #battery.plugged {
        color: ${colors.base0B};
      }

      #battery.warning {
        color: ${colors.base0A};
      }

      #battery.critical,
      #network.disconnected {
        color: ${colors.base0F};
      }
    '';
  };
}
