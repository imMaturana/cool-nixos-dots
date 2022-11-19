{ inputs, pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.desktop.sway;

  inherit (config.wayland.windowManager.sway.config) modifier;
  inherit (config.colorscheme) colors;

  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;

  fuzzel-menu = pkgs.writeScriptBin "fuzzel_menu" ''
    ${pkgs.fuzzel}/bin/fuzzel -p 'run ' \
    -f '${config.fontProfiles.regular.family}:size=10' -i '${config.gtk.iconTheme.name}' \
    -r 2 -B 3 -y 20 -P 10 \
    -b '${colors.base00}ff' -t '${colors.base06}ff' \
    -C '${colors.base0D}ff' -m '${colors.base08}ff' \
    -s '${colors.base02}ff' -S '${colors.base06}ff'
  '';
in
{
  options = {
    modules.desktop.sway = {
      enable = mkEnableOption "Enable sway";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fuzzel
      fuzzel-menu
      imv
      swaylock
      wl-clipboard
      grim
      slurp
      pamixer
      sway-contrib.grimshot
      wf-recorder
    ];

    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.sway-unwrapped;
      wrapperFeatures = { base = true; gtk = true; };
      xwayland = true;

      config = {
        output = {
          "*".bg = "${config.wallpaper} fill";
        };

        input = {
          "type:keyboard" = {
            xkb_layout = "us";
            xkb_variant = "colemak";
            xkb_options = "caps:swapescape";
          };

          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
          };
        };

        seat = {
          "type:touchpad" = {
            hide_cursor = "when-typing enabled";
          };
        };

        fonts = {
          names = [ config.fontProfiles.regular.family ];
          size = 10.0;
        };

        gaps = {
          inner = 4;
          outer = 4;
        };

        window = {
          titlebar = false;
          border = 3;

          commands = [
            {
              command = "floating enable, sticky enable";
              criteria = {
                app_id = "firefox";
                title = "^Picture-in-Picture$";
              };
            }
            {
              command = "floating enable, sticky enable";
              criteria = {
                app_id = "librewolf";
                title = "^Picture-in-Picture$";
              };
            }
          ];
        };

        floating = {
          border = 3;

          criteria = [
            {
              app_id = "org.keepassxc.KeePassXC";
            }
            {
              app_id = "mpv";
            }
          ];
        };

        modifier = "Mod4";

        keybindings = {
          # open terminal
          "${modifier}+Return" = "exec foot";

          # open launcher
          "${modifier}+p" = "exec fuzzel_menu";

          "${modifier}+Shift+c" = "kill";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left 20";
          "${modifier}+Shift+j" = "move down 20";
          "${modifier}+Shift+k" = "move up 20";
          "${modifier}+Shift+l" = "move right 20";

          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";
          "${modifier}+Up" = "sticky toggle";

          # modes
          "${modifier}+r" = "mode resize";
          "${modifier}+F11" = "mode passthrough";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";

          # scratchpad
          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioRaiseVolume" = "exec pamixer -i 5";
          "XF86AudioLowerVolume" = "exec pamixer -d 5";
          "Shift+XF86AudioMute" = "exec pamixer --default-source -t";
          "Shift+XF86AudioRaiseVolume" = "exec pamixer --default-source -i 5";
          "Shift+XF86AudioLowerVolume" = "exec pamixer --default-source -d 5";

          "Print" = "exec grimshot --notify save area ${config.xdg.userDirs.pictures}/$(date +%m-%d-%Y_%H-%M-%S).jpg";
          "Shift+Print" = "exec grimshot --notify save screen ${config.xdg.userDirs.pictures}/$(date +%m-%d-%Y_%H-%M-%S).jpg";
          "Shift+Control+Print" = "exec grimshot --notify save window ${config.xdg.userDirs.pictures}/$(date +%m-%d-%Y_%H-%M-%S).jpg";

          "XF86AudioPlay" = "exec mpc toggle";
          "XF86AudioPause" = "exec mpc toggle";
          "XF86AudioNext" = "exec mpc next";
          "XF86AudioPrev" = "exec mpc prev";
          "Shift+XF86AudioNext" = "exec mpc seek +10";
          "Shift+XF86AudioPrev" = "exec mpc seek -10";

          "XF86MonBrightnessUp" = "exec light -A 5";
          "XF86MonBrightnessDown" = "exec light -U 5";

          # toggle waybar
          "${modifier}+b" = "exec pkill -USR1 waybar";

          # layout
          "${modifier}+v" = "splitt";
          "${modifier}+t" = "layout toggle";

          "${modifier}+q" = "reload";
          "${modifier}+Shift+q" = "exec swaymsg exit";
        };

        modes = {
          resize = {
            "h" = "resize shrink width 50 px";
            "j" = "resize grow height 50 px";
            "k" = "resize shrink height 50 px";
            "l" = "resize grow width 50 px";
            "Escape" = "mode default";
            "Return" = "mode default";
          };

          passthrough = { "${modifier}+F11" = "mode default"; };
        };

        bars = [{ command = "waybar"; }];

        colors = {
          focused = {
            border = "#${colors.base0D}";
            background = "#${colors.base0D}";
            text = "#${colors.base00}";
            indicator = "#${colors.base0F}";
            childBorder = "";
          };

          focusedInactive = {
            border = "#${colors.base00}";
            background = "#${colors.base00}";
            text = "#${colors.base06}";
            indicator = "#${colors.base0F}";
            childBorder = "";
          };

          unfocused = {
            border = "#${colors.base00}";
            background = "#${colors.base00}";
            text = "#${colors.base06}";
            indicator = "#${colors.base0F}";
            childBorder = "";
          };

          urgent = {
            border = "#${colors.base08}";
            background = "#${colors.base08}";
            text = "#${colors.base00}";
            indicator = "#${colors.base0F}";
            childBorder = "";
          };
        };
      };

      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland

        # needs qt5.qtwayland in systemPackages
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      '';
    };

    systemd.user.services.fnott.Install.WantedBy = [ "sway-session.target" ];

    gtk = {
      enable = true;

      theme = {
        name = config.colorscheme.slug;
        package = gtkThemeFromScheme {
          scheme = config.colorscheme;
        };
      };

      iconTheme = {
        name = if config.colorscheme.kind == "light" then "Papirus" else "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
    };

    modules = {
      waybar.enable = true;
      foot.enable = true;
      swayidle.enable = mkDefault true;
      fnott.enable = true;
      wlsunset.enable = true;
      mpv.enable = mkDefault true;
      zathura.enable = mkDefault true;
      ncmpcpp.enable = mkDefault true;
    };
  };
}
