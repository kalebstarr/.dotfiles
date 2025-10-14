{ pkgs, ... }:

{

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.fzf = {
        enable = true;
        enableZshIntegration = true;
    };

}
