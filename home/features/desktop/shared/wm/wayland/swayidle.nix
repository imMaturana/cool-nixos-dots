{ pkgs
, ...
}:
{
  imports = [ ./swaylock.nix ];

  services.swayidle = {
    enable = true;

    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
    ];
  };
}
