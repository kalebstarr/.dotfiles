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

    ../home-modules/terminal/foot.nix
    ../home-modules/terminal/ghostty.nix

    ../home-modules/desktop/hyprland.nix
    ../home-modules/desktop/waybar.nix
    ../home-modules/desktop/stylix.nix
    inputs.stylix.homeModules.stylix

    ../home-modules/nixvim
  ];

  home.username = "kaleb";
  home.homeDirectory = "/home/kaleb";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    brave
    obsidian
    legcord
    protonvpn-gui
    openvpn
    godot

    htop
    fastfetch
    yazi
    ripgrep
    fd
    lazygit
    devenv

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    base16-schemes
  ];

  stylix.targets = {
    gtk.enable = true;
    gnome.enable = true;
    hyprland.enable = true;
  };

  programs.home-manager.enable = true;

}
