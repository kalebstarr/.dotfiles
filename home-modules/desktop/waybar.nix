{ pkgs, ... }:

{

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/mode"
        ];
        modules-center = [
          "clock"
          "clock#calendar"
        ];
        modules-right = [
          "tray"
          "backlight"
          "network"
          "pulseaudio"
          "battery"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "urgent" = "";
            "default" = "";
          };
        };

        clock = {
          format = "{:%H:%M}";
          tooltip = false;
        };
        "clock#calendar" = {
          format = "{:%d/%m}";
          tooltip = false;
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        network = {
          interval = 3;
          format-wifi = "  {essid}";
          format-ethernet = " {ifname}";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname} via {gwaddr} ";
          on-click = "nm-connection-editor"; # Opens network manager GUI
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
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
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
          tooltip = true;
        };

        "pulseaudio#mic" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = " Muted";
          on-click = "pavucontrol";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = {
            default = [
              ""
              ""
            ];
          };
          on-click = "pavucontrol"; # Opens PulseAudio volume control GUI
        };

      };
    };

    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: FiraCode Nerd Font, Noto Sans, sans-serif;
          font-size: 14px;
          min-height: 0;
      }

      window#waybar {
          background: rgba(26, 27, 38, 0.8);
          color: #cdd6f4; /* Text color */
      }

      #workspaces button {
          padding: 0 10px;
          margin: 2px;
          color: #a6adc8; /* Subdued text */
          border: 1px solid #a6adc8;
      }
      #workspaces button.active {
          color: #89b4fa; /* Blue */
          border: 1px solid #89b4fa;
      }
      #workspaces button.urgent {
          background-color: #f38ba8; /* Red */
      }

      #mode {
          background-color: #f9e2af; /* Yellow */
          color: #1e1e2e;
          padding: 0 10px;
          margin: 4px 0;
      }

      #clock, #cpu, #memory, #network, #pulseaudio, #tray, #battery {
          padding: 0 10px;
          margin: 4px 0;
      }
    '';
  };

}
