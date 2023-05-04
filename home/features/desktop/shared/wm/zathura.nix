{config, ...}: {
  programs.zathura = {
    enable = true;
    options = {
      font = config.fontProfiles.regular.family;
      default-bg = "#${config.colorscheme.colors.base00}";
      default-fg = "#${config.colorscheme.colors.base06}";
      inputbar-bg = "#${config.colorscheme.colors.base00}";
      inputbar-fg = "#${config.colorscheme.colors.base06}";

      statusbar-bg = "#${config.colorscheme.colors.base00}";
      statusbar-fg = "#${config.colorscheme.colors.base06}";
      statusbar-h-padding = 10;
      statusbar-v-padding = 8;

      recolor = true;
      recolor-lightcolor = "#${config.colorscheme.colors.base00}";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["zathura.desktop"];
      "application/epub" = ["zathura.desktop"];
    };
  };
}
