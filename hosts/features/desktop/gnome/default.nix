{ pkgs
, ...
}: {
  imports = [
    ../shared
  ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome-console
    gnome.nautilus
  ];

  services.gnome.core-utilities.enable = false;
}
