{ pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    shellAliases = {
      la = "ls -al";
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";

      plugins = [
        "git"
        "z"
        "fzf"
      ];
    };
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

  programs.tmux = {
    enable = true;
  };
  home.packages = with pkgs; [
    tmux
    (pkgs.writeShellScriptBin "ts" ''
      #!/bin/bash

      session_name="$(basename "$PWD" | sed 's/^\.*//')"

      while [[ $# -gt 0 ]]; do
        case $1 in
          -n|--name)
            session_name="$2"
            shift 2
            ;;
          *)
            echo "Usage: ts [-n|--name SESSION_NAME]"
            exit 1
            ;;
        esac
      done

      tmux new-session -d -s "$session_name" -n nvim
      tmux send-keys -t "$session_name:nvim" "nvim ." Enter
      tmux new-window -t "$session_name"
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
