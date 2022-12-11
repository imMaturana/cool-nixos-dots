{ pkgs
, config
, ...
}:

{
  programs.qutebrowser = {
    enable = true;

    quickmarks = {
      # email
      tutanota = "https://mail.tutanota.com/";
      anonaddy = "https://app.anonaddy.com/";

      # social
      mastodon = "https://mstdn.social/";
      lemmy = "https://lemmy.ml/";

      # media
      piped = "https://piped.kavin.rocks/";

      # development
      codeberg = "https://codeberg.org/";
      github = "https://github.com/";
    };

    settings = {
      fonts.default_family = config.fontProfiles.regular.family;
      fonts.default_size = "10pt";
      colors = with config.colorscheme.colors; {
        completion = {
          category.bg = "#${base01}";
          category.fg = "#${base06}";
          category.border.top = "#${base01}";
          category.border.bottom = "#${base01}";

          even.bg = "#${base02}";
          odd.bg = "#${base03}";
          fg = "#${base07}";
          match.fg = "#${base08}";
          item.selected.bg = "#${base0B}";
          item.selected.fg = "#${base00}";
          item.selected.border.top = "#${base00}";
          item.selected.border.bottom = "#${base00}";
        };

        statusbar = {
          normal.bg = "#${base00}";
          normal.fg = "#${base07}";

          command.bg = "#${base00}";
          command.fg = "#${base07}";

          passthrough.bg = "#${base09}";
          passthrough.fg = "#${base07}";

          url.fg = "#${base0B}";
          url.error.fg = "#${base08}";
          progress.bg = "#${base07}";
        };
      };
    };

    searchEngines = {
      ddg = "https://duckduckgo.com/?q={}";
      g = "https://google.com/search?q={}";
      yt = "https://youtube.com/search?q={}";
    };

    keyBindings = {
      normal = {
        ",v" = "spawn ${pkgs.mpv}/bin/mpv {url}";
        ",y" = "spawn ${pkgs.yt-dlp}/bin/yt-dlp {url} -o ${config.xdg.userDirs.videos}/%(title)s.%(ext)s";
      };
    };
  };
}

