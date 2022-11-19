{ inputs
, pkgs
, lib
, config
, hostname
, ...
}:

with lib;

let
  cfg = config.modules.desktop.hyprland;

  inherit (config.colorscheme) colors;

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
    modules.desktop.hyprland = {
      enable = mkEnableOption "Enable hyprland";
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.hyprpaper.overlays.default ];

    home.packages = with pkgs; [
      fuzzel
      fuzzel-menu
      imv
      swaylock
      wl-clipboard
      grim
      slurp
      pamixer
      wf-recorder
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;

      extraConfig = ''
        monitor=eDP-1,1920x1080@60,1x1,1
        workspace=eDP-1,1

        general {
          main_mod=SUPER
          gaps_in=5
          gaps_out=20
          border_size=2
          col.active_border=0xff${colors.base0B}
          col.inactive_border=0xff${colors.base00}
        }

        input {
          kb_layout=us
          kb_variant=colemak
          kb_options=caps:swapescape
        }

        # startup
        exec-once=waybar
        exec=${pkgs.hyprpaper}/bin/hyprpaper

        # keybindings
        bind=SUPER,Return,exec,foot
        bind=SUPER,C,killactive,
        bind=SUPER,Q,exit,
        bind=ALT,P,exec,fuzzel_menu
        bind=SUPER,V,togglefloating,
        bind=SUPER,P,pseudo,

        bind=SUPER,left,movefocus,l
        bind=SUPER,right,movefocus,r
        bind=SUPER,up,movefocus,u
        bind=SUPER,down,movefocus,d

        bind=SUPER,1,workspace,1
        bind=SUPER,2,workspace,2
        bind=SUPER,3,workspace,3
        bind=SUPER,4,workspace,4
        bind=SUPER,5,workspace,5
        bind=SUPER,6,workspace,6
        bind=SUPER,7,workspace,7
        bind=SUPER,8,workspace,8
        bind=SUPER,9,workspace,9

        bind=SUPERSHIFT,exclam,movetoworkspace,1
        bind=SUPERSHIFT,at,movetoworkspace,2
        bind=SUPERSHIFT,numbersign,movetoworkspace,3
        bind=SUPERSHIFT,dollar,movetoworkspace,4
        bind=SUPERSHIFT,percent,movetoworkspace,5
        bind=SUPERSHIFT,asciicircum,movetoworkspace,6
        bind=SUPERSHIFT,ampersand,movetoworkspace,7
        bind=SUPERSHIFT,asterisk,movetoworkspace,8
        bind=SUPERSHIFT,parenleft,movetoworkspace,9

        bind=,XF86AudioMute,exec,pamixer -t
        bind=,XF86AudioRaiseVolume,exec,pamixer -i 5
        bind=,XF86AudioLowerVolume,exec,pamixer -d 5
        bind=,XF86MonBrightnessUp,exec,light -A 10
        bind=,XF86MonBrightnessDown,exec,light -U 10
      '';
    };

    xdg.configFile."hypr/hyprpaper.conf" = mkIf (!isNull config.wallpaper) {
      text = ''
        preload = ${config.wallpaper}

        wallpaper = eDP-1,${config.wallpaper}
      '';
    };

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
      foot.enable = true;
      waybar.enable = true;
      wlsunset.enable = true;
      fnott.enable = true;
      mpv.enable = mkDefault true;
      zathura.enable = mkDefault true;
      ncmpcpp.enable = mkDefault true;
    };
  };
}
