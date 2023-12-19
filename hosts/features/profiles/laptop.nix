{ config
, ...
}: {
  imports = [
    ../bluetooth.nix
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  boot.kernelModules = [ "acpi_call" ];

  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;
}
