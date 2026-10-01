{ pkgs, ... }:

{

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kaleb";
        email = "kaleb.starr@proton.me";
      };
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

}
