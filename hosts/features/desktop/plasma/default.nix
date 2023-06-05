{pkgs, ...}: {
  imports = [
    ../shared
  ];

  services.xserver = {
    enable = true;

    displayManager.sddm = {
      enable = true;
    };

    desktopManager.plasma5 = {
      enable = true;
      runUsingSystemd = true;
    };
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.kaccounts-integration
    libsForQt5.kaccounts-providers
    libsForQt5.kio
    libsForQt5.kio-gdrive
  ];
}
