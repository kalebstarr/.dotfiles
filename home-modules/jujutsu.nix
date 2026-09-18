{ ... }:

{

  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        name = "Kaleb";
        email = "kaleb.starr@proton.me";
      };

      ui = {
        default-command = "log";
        pager = "less -FRX";
      };
    };
  };

}
