{
  config,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    ./home/hyprland.nix
    ./home/waybar.nix
    ./home/theming.nix
    ./home/sh.nix
    ./home/terminal.nix

    inputs.nixvim.homeModules.nixvim
    ./home/nixvim.nix
    ./nixvim/keymaps.nix
    ./nixvim/options.nix
    ./nixvim/plugins/treesitter.nix
  ];

  home.username = "kaleb";
  home.homeDirectory = "/home/kaleb";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
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
    ripgrep
    fd
    lazygit

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono

    gcc
    gdb
    cmake
    rustc
    cargo
    clippy
    rustfmt
    uv

    stylua
    nixfmt
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kaleb";
        email = "kaleb.starr@proton.me";
      };
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
