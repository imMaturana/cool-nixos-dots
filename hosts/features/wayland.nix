{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    pulse.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  services.xserver.displayManager.gdm.wayland = true;

  security.rtkit.enable = true;
  security.pam.services.swaylock = {};

  hardware.pulseaudio.enable = false;

  environment.systemPackages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
  ];
}
