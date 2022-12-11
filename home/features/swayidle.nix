{config, ...}: {
  services.swayidle = {
    enable = true;

    timeouts = [
      {
        timeout = 300;
        command = "swaylock";
      }
      {
        timeout = 600;
        command = "swaymsg 'output * dpms off'";
        resumeCommand = "swaymsg 'output * dpms on'";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "swaylock";
      }
    ];
  };

  programs.swaylock.settings = {
    font = config.fontProfiles.regular.family;
    font-size = 16;

    color = config.colorscheme.colors.base00;

    key-hl-color = config.colorscheme.colors.base0B;

    inside-color = config.colorscheme.colors.base00;
    inside-wrong-color = config.colorscheme.colors.base00;

    ring-color = config.colorscheme.colors.base02;
    ring-ver-color = config.colorscheme.colors.base0A;
    ring-wrong-color = config.colorscheme.colors.base08;
  };
}
