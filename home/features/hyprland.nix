{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  inherit (config.colorscheme) colors;
in {
  imports = [./wayland.nix];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      ${concatStrings (map (
          m: ''
            monitor=${m},preferred,auto,1
            workspace=${m},1
          ''
        )
        config.home.monitors)}

      input {
        kb_layout=${config.home.keyboard.layout}
        kb_variant=${config.home.keyboard.variant}
        kb_options=${concatStringsSep "," config.home.keyboard.options}

        follow_mouse=1
        touchpad {
          natural_scroll=1
        }
      }

      general {
        gaps_in=10
        gaps_out=15
        border_size=2.5
        col.active_border=0xff${colors.base0B}
        col.inactive_border=0xff${colors.base00}
        cursor_inactive_timeout=4
      }

      decoration {
        rounding=5

        drop_shadow=1
        shadow_ignore_window=1
        shadow_offset=4 4
        shadow_range=4.5
        col.shadow=0x88000000
      }

      # startup
      exec-once=waybar
      exec=hyprpaper

      # window rules
      windowrule=float,^(mpv)$
      windowrule=float,^(org.keepassxc.KeePassXC)$

      # mouse
      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow

      # programs
      bind=SUPER,Return,exec,foot
      bind=SUPER,W,exec,librewolf
      bindr=SUPER,P,exec,pkill fuzzel || fuzzel_menu

      # compositor
      bind=SUPERSHIFT,Q,exit,
      bind=SUPERSHIFT,C,killactive,
      bind=SUPER,F,fullscreen,
      bind=SUPER,T,togglefloating,

      # move focus
      bind=SUPER,left,movefocus,l
      bind=SUPER,right,movefocus,r
      bind=SUPER,up,movefocus,u
      bind=SUPER,down,movefocus,d

      # workspaces
      ${concatStrings (genList (
          x: let
            ws = toString (x + 1);
          in ''
            bind=SUPER,${ws},workspace,${ws}
            bind=SUPERSHIFT,${ws},movetoworkspace,${ws}
          ''
        )
        9)}

      # media
      bind=,XF86AudioPlay,exec,mpc toggle
      bind=,XF86AudioNext,exec,mpc next
      bind=,XF86AudioPrev,exec,mpc prev

      # volume
      bind=,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind=,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bind=,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

      # brightness
      bind=,XF86MonBrightnessUp,exec,light -A 10
      bind=,XF86MonBrightnessDown,exec,light -U 10
    '';
  };

  programs.hyprpaper = {
    enable = true;
    monitors =
      map (m: {
        name = m;
        inherit (config) wallpaper;
      })
      config.home.monitors;
  };
}
