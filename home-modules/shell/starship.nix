{ pkgs, ... }:

{

  programs.starship = {
    enable = true;
    settings =
      let
        langFormat = "[$version]($style) ";
      in
      {
        format = "$directory$git_branch$git_status$nix_shell$python$nodejs$rust$golang$java$ruby$lua$zig$cmd_duration$line_break$character";

        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
        };

        directory = {
          truncation_length = 3;
          truncate_to_repo = true;
        };

        git_branch.format = "[$branch]($style) ";

        git_status = {
          format = "[$all_status$ahead_behind]($style) ";
          conflicted = "!";
          ahead = "⇡";
          behind = "⇣";
          diverged = "⇕";
          untracked = "?";
          stashed = "";
          modified = "~";
          staged = "+";
          renamed = "»";
          deleted = "✘";
        };

        cmd_duration = {
          min_time = 2000;
          format = "[$duration]($style) ";
        };

        nix_shell.format = "[nix]($style) ";

        python.format = langFormat;
        nodejs.format = langFormat;
        rust.format = langFormat;
        golang.format = langFormat;
        java.format = langFormat;
        zig.format = langFormat;
      };
  };

}
