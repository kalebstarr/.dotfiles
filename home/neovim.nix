{ nvim-config, ... }:

{

  xdg.configFile."nvim" = {
    source = nvim-config;
    recursive = true;
  };

}
