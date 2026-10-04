{ inputs, pkgs, ... }:

let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./modules/shell/zsh.nix
    ./modules/shell/starship.nix
    ./modules/shell/fzf.nix
    ./modules/shell/zoxide.nix
    ./modules/shell/direnv.nix
    ./modules/shell/scripts.nix
    ./modules/git.nix
    ./modules/ssh.nix
    ./modules/tmux.nix
    ./modules/esp32.nix

    ./modules/terminal/ghostty.nix

    ./modules/nixvim
  ];

  home = {
    username = "kaleb";
    homeDirectory = "/home/kaleb";
    stateVersion = "26.05";

    packages =
      (with pkgs; [
        htop
        fastfetch
        yazi
        ripgrep
        fd
        lazygit
        devenv
        python3
      ])
      ++ (with llm-agents; [
        pi
      ]);
  };

  programs.home-manager.enable = true;
}
