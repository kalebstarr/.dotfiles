{
  config,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    ./home/sh.nix
    ./home/tmux.nix

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
    yazi
    ghostty

    fzf
    zoxide
    oh-my-zsh
    tmux
    ripgrep
    fd
    lazygit
    devenv

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

  services.ssh-agent.enable = false;

  programs.home-manager.enable = true;

}
