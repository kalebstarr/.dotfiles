{
  config,
  pkgs,
  inputs,
  ...
}:

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

    ../home-modules/terminal/ghostty.nix

    ../home-modules/desktop/stylix.nix
    inputs.stylix.homeModules.stylix

    ../home-modules/nixvim
  ];

  home.username = "kaleb";
  home.homeDirectory = "/home/kaleb";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    htop
    fastfetch
    yazi
    ripgrep
    fd
    lazygit
    devenv
  ];

  programs.home-manager.enable = true;

}
