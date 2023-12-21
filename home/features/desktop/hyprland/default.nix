{ lib
, config
, ...
}:
with lib; let
  inherit (config.colorscheme) colors;
in
{
  imports = [
    ../shared
    ../shared/wm
    ../shared/wm/wayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      input = {
        kb_layout = config.home.keyboard.layout;
        kb_variant = config.home.keyboard.variant;
        kb_options = config.home.keyboard.options;

        follow_mouse = "1";
        touchpad.natural_scroll = "1";
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;
        "col.active_border" = "0xff${colors.base0B}";
        "col.inactive_border" = "0xff${colors.base00}";
        cursor_inactive_timeout = 4;
      };

      decoration = {
        rounding = 3;


        drop_shadow = 1;
        shadow_ignore_window = 1;
        shadow_offset = "4 4";
        shadow_range = 4.5;
        "col.shadow" = "0x88000000";
      };

      exec-once = ["waybar"];
      exec = ["hyprpaper"];

      windowrule = [
        "float,^(mpv)$"
        "float,^(org.keepassxc.KeePassXC)$"
      ];

      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];

      bind = [
        "$mod,Return,exec,foot"
        "$mod,W,exec,librewolf"

        # compositor
        "SUPERSHIFT,Q,exit,"
        "SUPERSHIFT,C,killactive,"
        "$mod,F,fullscreen,"
        "$mod,T,togglefloating,"

        # move focus
        "$mod,left,movefocus,l"
        "$mod,right,movefocus,r"
        "$mod,up,movefocus,u"
        "$mod,down,movefocus,d"

        # scratchpad
        "SUPERSHIFT,S,movetoworkspace,special"
        "SUPER,S,togglespecialworkspace,"

        # media
        ",XF86AudioPlay,exec,mpc toggle"
        ",XF86AudioNext,exec,mpc next"
        ",XF86AudioPrev,exec,mpc prev"

        # volume
        ",XF86AudioMute,exec,wpctl set-mute @DEFAUL_AUDIO_SINK@ toggle"
        ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

        # brightness
        ",XF86MonBrightnessUp,exec,light -A 10"
        ",XF86MonBrightnessDown,exec,light -U 10"

        # screenshot
        ",Print,exec,grimshot --notify save area ${config.xdg.userDirs.pictures}/$(date +%d-%m-%Y_%H-%M-%S).jpg"
        "SHIFT,Print,exec,grimshot --notify save screen ${config.xdg.userDirs.pictures}/$(date +%d-%m-%Y_%H-%M-%S).jpg"
        "CTRLSHIFT,Print,exec,grimshot --notify save window ${config.xdg.userDirs.pictures}/$(date +%d-%m-%Y_%H-%M-%S).jpg"
      ] ++ concatLists (genList (x: let
        ws = toString (x + 1);
      in [
        "SUPER,${ws},workspace,${ws}"
        "SUPERSHIFT,${ws},movetoworkspace,${ws}"
      ]) 9);

      bindr = [
        "$mod,P,exec,pkill fuzzel || fuzzel"
      ];

      env = ["XCURSOR_SIZE,32"];
    };
  };

  programs.hyprpaper = {
    enable = true;
    monitors =
      map (m: { inherit (m) name wallpaper; }) config.home.monitors;
  };

  services.swayidle.timeouts = [
    {
      timeout = 300;
      command = "swaylock";
    }
    {
      timeout = 305;
      command = "hyprctl dispatch dpms off";
      resumeCommand = "hyprctl dispatch dpms on";
    }
  ];

  systemd.user.services.fnott.Install.WantedBy = [ "hyprland-session.target" ];
  systemd.user.services.swayidle.Install.WantedBy = [ "hyprland-session.target" ];
}
