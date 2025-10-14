{ pkgs, ... }:

{

  programs.waybar = {
    enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
	position = "top";
	height = 30;
	modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
	modules-right = [ "tray" "network" "pulseaudio" "cpu" "memory" "clock" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "🎵";
            "urgent" = "";
            "default" = "";
          };
        };

	tray = {
	  icon-size = 18;
	  spacing = 10;
	};

	clock = {
	  format = " {:%H:%M}";
	  format-alt = " {:%d/%m/%Y}";
	  tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	};

	cpu = {
	  format = " {usage}%";
	  tooltip = true;
	};

	memory = {
	  format = " {}%";
	};

	network = {
          format-wifi = "  {essid}";
          format-ethernet = " {ifname}";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname} via {gwaddr} ";
          on-click = "nm-connection-editor"; # Opens network manager GUI
        };

	pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = {
            default = [ "" "" ];
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
          color: #a6adc8; /* Subdued text */
      }
      #workspaces button.active {
          color: #89b4fa; /* Blue */
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

      #clock, #cpu, #memory, #network, #pulseaudio, #tray {
          padding: 0 10px;
          margin: 4px 0;
      }
    '';
  };

}
