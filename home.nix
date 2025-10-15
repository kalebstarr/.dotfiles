{ config, pkgs, ... }:

{

  imports = [
    ./home/hyprland.nix
    ./home/waybar.nix
    ./home/theming.nix
    ./home/neovim.nix
    ./home/sh.nix
  ];

  home.username = "kaleb";
  home.homeDirectory = "/home/kaleb";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neovim
    zsh
    htop
    fastfetch
    brave
    obsidian
    yazi

    waybar
    hyprpaper

    fzf
    zoxide
    oh-my-zsh
    tmux

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono

    ripgrep
    fd
    lazygit

    gcc
    gdb
    cmake
    rustc
    cargo
    clippy
    rustfmt
    uv

    lua-language-server
    clang-tools
    zls
    rust-analyzer
    typescript-language-server
    ruff

    stylua
    nixfmt
  ];

  programs.git = {
    enable = true;
    userName = "Kaleb";
    userEmail = "kaleb.starr@proton.me";

    extraConfig = {
      core.editor = "vim";
      init.defaultBranch = "main";
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

  programs.home-manager.enable = true;

}
