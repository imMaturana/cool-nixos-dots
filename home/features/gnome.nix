{ pkgs
, ...
}:

{
  home.packages = with pkgs; [
    amberol
  ];
  
  desktopEnvironment.gnome = {
    enable = true;
    themeVariant = "dark";
    
    bindings = {
      "<Ctrl><Alt>T" = "kgx";
    };
    
    nightLight = {
      enable = true;
      temperature = 3500;
    };
  };
}
