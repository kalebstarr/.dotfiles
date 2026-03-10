{ pkgs, ... }:

{

  home.packages = with pkgs; [
    waybar
    swaybg
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {
      monitor = "eDP-1,1920x1080@60,auto,1";

      exec-once = [
        "waybar"
        "swaybg -i ${../../wallpapers/Sunset.png} -m fill"
      ];

      input = {
        kb_layout = "de";
        kb_variant = "nodeadkeys";
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };

      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 2;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
      };
      animations = {
        enabled = true;
        bezier = [ "myBezier,0.05,0.9,0.1,1" ];
        animation = [
          "windows,1,7,myBezier"
          "fade,1,5,default"
          "workspaces,1,6,myBezier"
        ];
      };

      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, D, exec, wofi --show drun"
        "$mainMod, E, exec, thunar"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, F, togglefloating,"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"

        ",XF86AudioRaiseVolume,exec,pamixer -i 5"
        ",XF86AudioLowerVolume,exec,pamixer -d 5"
        ",XF86AudioMute,exec,pamixer -t"
        ",XF86AudioMicMute,exec,pamixer --default-source -t"
        ",XF86MonBrightnessUp,exec,brightnessctl set +10%"
        ",XF86MonBrightnessDown,exec,brightnessctl set 10%-"
        ",XF86Display,exec,hyprctl dispatch dpms toggle"
        ",XF86Favorites,exec,playerctl play-pause"
      ];
    };
  };

}
