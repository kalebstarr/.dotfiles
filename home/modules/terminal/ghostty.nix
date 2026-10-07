{ ... }:

{

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-size = 12;

      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;
      background-opacity = 0.9;
      background-blur-radius = 32;

      cursor-style = "block";
      cursor-style-blink = true;
      scrollback-limit = 3023;

      mouse-hide-while-typing = true;
      copy-on-select = false;
      confirm-close-surface = false;
      app-notifications = false;

      keybind = [
        "ctrl+shift+n=new_window"
        "ctrl+plus=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+zero=reset_font_size"
        "shift+enter=text:\\n"
      ];

      unfocused-split-opacity = 0.7;
      unfocused-split-fill = "#44464f";
      gtk-titlebar = false;

      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,title,no-cursor";
      gtk-single-instance = true;

      # DMS regenerates ~/.config/ghostty/themes/dankcolors.
      # Keep that file writable rather than declaring it in Ghostty's themes.
      theme = "dankcolors";
    };
  };

}
