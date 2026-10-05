{ pkgs, ... }:

{

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    escapeTime = 0;
    secureSocket = false;
    mouse = true;
    clock24 = true;
    historyLimit = 50000;
    terminal = "tmux-256color";

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_status_background "none"
          set -g @catppuccin_window_status_style "none"
        '';
      }
    ];

    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -as terminal-features ',xterm-ghostty:RGB'
      set-environment -g COLORTERM "truecolor"

      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      set -s extended-keys on
      set -s extended-keys-format csi-u
    '';
  };

}
