{ config, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        app-id = "foot";
        title = "foot";
        term = "xterm-256color";
        font = "${config.home.fonts.monospace.family}:size=7";
        pad = "10x10";
        dpi-aware = "true";
      };

      bell = {
        urgent = "no";
        notify = "no";
      };

      colors = with config.colorscheme; {
        alpha = 1.0;

        background = colors.base00;
        foreground = colors.base06;
        regular0 = colors.base01;
        regular1 = colors.base08;
        regular2 = colors.base0B;
        regular3 = colors.base0A;
        regular4 = colors.base0D;
        regular5 = colors.base0E;
        regular6 = colors.base0C;
        regular7 = colors.base06;
        bright0 = colors.base02;
        bright1 = colors.base08;
        bright2 = colors.base0B;
        bright3 = colors.base0A;
        bright4 = colors.base0D;
        bright5 = colors.base0E;
        bright6 = colors.base0C;
        bright7 = colors.base07;
      };
    };
  };
}
