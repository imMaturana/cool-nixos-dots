{pkgs, lib, ... }: {
  imports = [
    ../shared
  ];

  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = { 
      command = "${lib.getExe pkgs.greetd.tuigreet} -c Hyprland";
    };
  };
}
