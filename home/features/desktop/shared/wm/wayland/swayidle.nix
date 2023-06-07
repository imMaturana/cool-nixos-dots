{ config, ... }: {
  services.swayidle = {
    enable = true;

    events = [
      {
        event = "before-sleep";
        command = "swaylock";
      }
    ];
  };

  programs.swaylock.settings = {
    font = config.home.fonts.regular.family;
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
