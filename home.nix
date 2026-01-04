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
    ./home/sh.nix
    ./home/terminal.nix
    ./home/tmux.nix
    inputs.stylix.homeModules.stylix

    inputs.nixvim.homeModules.nixvim
    ./nixvim.nix
    ./nixvim/keymaps.nix
    ./nixvim/options.nix
    ./nixvim/plugins/treesitter.nix
    ./nixvim/plugins/lsp-config.nix
    ./nixvim/plugins/telescope.nix
    ./nixvim/plugins/comment.nix
    ./nixvim/plugins/completions.nix
    ./nixvim/plugins/lazygit.nix
    ./nixvim/plugins/lualine.nix
    ./nixvim/plugins/formatters.nix
    ./nixvim/plugins/todo-comments.nix
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
    discord
    ghostty
    protonvpn-gui
    openvpn
    godot

    waybar

    fzf
    zoxide
    oh-my-zsh
    tmux
    ripgrep
    fd
    lazygit

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono

    base16-schemes

    gcc
    gdb
    cmake
    rustc
    cargo
    clippy

    stylua
    nixfmt
    ruff
    rustfmt
    clang-tools
    prettier
  ];

  services.ssh-agent.enable = true;

  programs.home-manager.enable = true;

}
