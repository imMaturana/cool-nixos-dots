{ config, ... }: {
  imports = [ ./swaylock.nix ];

  services.swayidle = {
    enable = true;

    events = [
      {
        event = "before-sleep";
        command = "swaylock";
      }
    ];
  };
}
