{ pkgs, ... }:

{

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kaleb";
        email = "kaleb.starr@proton.me";
      };
      core.editor = "vim";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

}
