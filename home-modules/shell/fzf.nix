{ pkgs, ... }:

{

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # Preserve the former Oh My Zsh plugin default; HM owns the widgets.
    defaultCommand = "fd --type f --hidden --exclude .git";
  };

}
