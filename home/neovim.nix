{ pkgs, ... }:

{

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        extraPackages = with pkgs; [];
    };

    home.file.".config/nvim".source = ../nvim-config;

}
