{ pkgs, ... }:

{

  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$nix_shell$python$nodejs$rust$golang$cmd_duration$line_break$character";

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        format = "[$branch]($style) ";
      };

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

      nix_shell = {
        format = "[nix]($style) ";
      };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      la = "ls -al";
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    };

    oh-my-zsh = {
      enable = true;

      plugins = [
        "git"
        "z"
        "fzf"
      ];
    };

    initContent = ''
      eval "$(starship init zsh)"
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kaleb";
        email = "kaleb.starr@proton.me";
      };
      core.editor = "vim";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_ed25519";
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  services.ssh-agent.enable = true;

  programs.tmux = {
    enable = true;
  };
  home.packages = with pkgs; [
    tmux
    (pkgs.writeShellScriptBin "ts" ''
      set -euo pipefail

      session_name=$(basename "$PWD" | sed 's/^\.*//')
      extra_windows=1

      while [[ $# -gt 0 ]]; do
        case $1 in
          -n|--name)
            if [[ -z "''${2:-}" ]]; then echo "Error: Name required"; exit 1; fi
            session_name="$2"
            shift 2
            ;;
          -w|--windows)
            if [[ -z "''${2:-}" ]]; then echo "Error: Window count required"; exit 1; fi
            extra_windows="$2"
            shift 2
            ;;
          *)
            echo "Usage: ts [-n|--name NAME] [-w|--windows COUNT]"
            exit 1
            ;;
        esac
      done

      if ! [[ "$extra_windows" =~ ^[0-9]+$ ]] || [ "$extra_windows" -lt 1 ]; then
        echo "Error: Window count must be an integer >= 1"
        exit 1
      fi

      if ! tmux has-session -t "$session_name" 2>/dev/null; then
        tmux new-session -d -s "$session_name" -n nvim
        tmux send-keys -t "$session_name:nvim" "nvim ." Enter

        for ((i=1; i<=extra_windows; i++)); do
          tmux new-window -t "$session_name"
        done
      fi

      tmux attach-session -t "$session_name:nvim"
    '')
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

}
