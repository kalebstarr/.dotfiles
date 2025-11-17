{
  config,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    ./home/sh.nix
    ./home/terminal.nix
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
