{ config, pkgs, ... }:

{

  imports = [
    ./home/hyprland.nix
    ./home/waybar.nix
    ./home/theming.nix
    ./home/neovim.nix
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

    signing = {
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
    };

    extraConfig = {
        gpg.format = "ssh";
    };
  };

  programs.zsh.enable = true;

  programs.home-manager.enable = true;

}
