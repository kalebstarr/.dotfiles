{ inputs, pkgs, ... }:

let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ../home-modules/shell/zsh.nix
    ../home-modules/shell/starship.nix
    ../home-modules/shell/fzf.nix
    ../home-modules/shell/zoxide.nix
    ../home-modules/shell/direnv.nix
    ../home-modules/shell/scripts.nix
    ../home-modules/git.nix
    ../home-modules/ssh.nix
    ../home-modules/tmux.nix
    ../home-modules/esp32.nix

    ../home-modules/terminal/ghostty.nix

    ../home-modules/desktop/stylix.nix
    inputs.stylix.homeModules.stylix

    ../home-modules/nixvim
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
        opencode2
        pi
      ]);
  };

  programs.home-manager.enable = true;
}
