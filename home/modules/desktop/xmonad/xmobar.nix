{ config, ... }:

let
  inherit (config.colorscheme) colors;
in
{
  programs.xmobar = {
    enable = config.xsession.windowManager.xmonad.enable;
    extraConfig = ''
      Config
        { font = "xft:${config.fontProfiles.monospace.family}:size=10:antialias=true"
        , bgColor = "#${colors.base00}"
        , fgColor = "#${colors.base06}"
        , position = Top

        -- border
        , border = BottomB
        , borderColor = "#${colors.base00}"

        -- layout
        , sepChar = "%"
        , alignSep = "}{"

        -- general behavior
        , lowerOnStart = True
        , hideOnStart = False
        , allDesktops = True
        , overrideRedirect = True
        , pickBroadest = False
        , persistent = True

        , commands =
          [ Run Volume "default" "Master" [] 10
          , Run Date "%d/%m/%Y [%H:%M]" "date" 10
          , Run UnsafeStdinReader
          ]

        , template = " %UnsafeStdinReader% }{  %default:Master%  %date% "
        }
    '';
  };
}
