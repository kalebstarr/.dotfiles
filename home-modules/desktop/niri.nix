{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swaybg
    wofi
    xwayland-satellite
  ];

  xdg.configFile."niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "de"
                variant "nodeadkeys"
            }
        }

        touchpad {
            natural-scroll
        }

        focus-follows-mouse
    }

    output "eDP-1" {
        mode "1920x1080@60"
        scale 1
    }

    layout {
        gaps 8

        focus-ring {
            width 2
            active-color "#89b4fa"
            inactive-color "#45475a"
        }

        border {
            off
        }

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }
    }

    prefer-no-csd

    spawn-at-startup "swaybg" "-i" "${../../wallpapers/Sunset.png}" "-m" "fill"
    spawn-at-startup "xwayland-satellite"
    spawn-at-startup "quickshell" "-c" "noctalia"

    binds {
        Mod+Return { spawn "ghostty"; }
        Mod+D { spawn "wofi" "--show" "drun"; }
        Mod+E { spawn "thunar"; }
        Mod+Q { close-window; }
        Mod+M { quit; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }

        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+K { focus-window-up; }
        Mod+J { focus-window-down; }

        Mod+Shift+H { move-column-left; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+K { move-window-up; }
        Mod+Shift+J { move-window-down; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }

        Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn "pamixer" "-i" "5"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "pamixer" "-d" "5"; }
        XF86AudioMute allow-when-locked=true { spawn "pamixer" "-t"; }
        XF86AudioMicMute allow-when-locked=true { spawn "pamixer" "--default-source" "-t"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "set" "+10%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "10%-"; }
        XF86Favorites allow-when-locked=true { spawn "playerctl" "play-pause"; }
    }
  '';
}
