{ inputs
, pkgs
, config
, ...
}:

let
  inherit (config.colorscheme) colors;
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;

  pamixer = "${pkgs.pamixer}/bin/pamixer";
  feh = "${pkgs.feh}/bin/feh";
  xmobar = "${config.programs.xmobar.package}/bin/xmobar";
in
{
  imports = [ ./x11.nix ];
  
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = hpkgs: with hpkgs; [
      xmonad-contrib
      xmonad-extras
    ];

    config = pkgs.writeText "xmonad.hs" ''
      -- Imports {{{

      import XMonad
      import System.Exit

      -- Util
      import XMonad.Util.EZConfig (mkKeymap)
      import XMonad.Util.SpawnOnce
      import XMonad.Util.Run

      -- Hooks
      import XMonad.Hooks.DynamicLog
      import XMonad.Hooks.ManageDocks
      import XMonad.Hooks.EwmhDesktops

      -- Layout
      import XMonad.Layout.Spacing

      -- Data
      import Data.Monoid

      -- Prompt
      import XMonad.Prompt
      import XMonad.Prompt.Shell

      -- Qualified
      import qualified XMonad.StackSet as W
      import qualified Data.Map        as M

      -- }}}

      -- Variables {{{

      -- Mod Mask
      myModMask :: KeyMask
      myModMask = mod4Mask

      -- Terminal
      myTerminal :: String
      myTerminal = "alacritty"

      -- Focus Follows Mouse
      myFocusFollowsMouse :: Bool
      myFocusFollowsMouse = False

      -- Border Width
      myBorderWidth :: Dimension
      myBorderWidth = 2

      -- Border Color
      myNormalBorderColor :: String
      myNormalBorderColor = "#${colors.base00}"

      myFocusedBorderColor :: String
      myFocusedBorderColor = "#${colors.base0B}"

      -- Workspaces
      myWorkspaces :: [WorkspaceId]
      myWorkspaces = map show [1..9]
      
      -- XPConfig
      myXPConfig :: XPConfig
      myXPConfig = def
        { font = "xft:${config.fontProfiles.regular.family}:size=10"
        , height = 30
        , bgColor = "#${colors.base00}"
        , fgColor = "#${colors.base06}"

        , promptBorderWidth = 3
        , borderColor = "#${colors.base02}"
       
        , position = CenteredAt { xpCenterY = 0.5, xpWidth = 0.5 }
        }

      -- Keys
      myKeys = \c -> mkKeymap c $
        
        -- launch a terminal
        [ ("M-S-<Return>", spawn $ XMonad.terminal c)

        -- launch a prompt
        , ("M-p", shellPrompt myXPConfig)

        -- close focused window
        , ("M-S-c", kill)

        -- rotate through the available layout algorithms
        , ("M-<Space>", sendMessage NextLayout)

        -- reset the layouts on the current workspace to default
        , ("M-S-<Space>", setLayout $ XMonad.layoutHook c)

        -- resize viewed windows to the current size
        , ("M-n", refresh)

        -- move focus to the next window
        , ("M-<Tab>", windows W.focusDown)

        -- move focus to the next window
        , ("M-j", windows W.focusDown)

        -- move focus to the previous window
        , ("M-k", windows W.focusUp)

        -- move focus to the master window
        , ("M-m", windows W.focusMaster)

        -- swap the focused window with the next window
        , ("M-S-j", windows W.swapDown)

        -- swap the focused window with the previous window
        , ("M-S-k", windows W.swapUp)

        -- swap the focused window with the master window
        , ("M-<Return>", windows W.swapMaster)

        -- shrink the master area
        , ("M-h", sendMessage Shrink)

        -- expand the master area
        , ("M-l", sendMessage Expand)

        -- push window back into tiling
        , ("M-t", withFocused $ windows . W.sink)

        -- increment the number of windows in the master area
        , ("M-,", sendMessage (IncMasterN 1))

        -- decrement the number of windows in the master area
        , ("M-.", sendMessage (IncMasterN (-1)))

        -- quit XMonad
        , ("M-S-q", io (exitWith ExitSuccess))

        -- restart XMonad
        , ("M-q", spawn "xmonad --restart")

        -- toggle mute volume
        , ("<XF86AudioMute>", spawn "${pamixer} -t")

        -- increase volume
        , ("<XF86AudioRaiseVolume>", spawn "${pamixer} -i 5")

        -- decrease volume
        , ("<XF86AudioLowerVolume>", spawn "${pamixer} -d 5")

        -- increase brightness
        , ("<XF86MonBrightnessUp>", spawn "light -A 10")

        -- decrease brightness
        , ("<XF86MonBrightnessDown>", spawn "light -U 10")
        ]
        ++
        [("M-" ++ m ++ k, windows $ f i)
          | (i, k) <- zip (XMonad.workspaces c) (map show [1..9])
          , (f, m) <- [(W.greedyView, ""), (W.shift, "S-")]]

      -- Mouse
      myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

        -- mod-button1, set the window to floating mode and move by dragging
        [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                            >> windows W.shiftMaster))

        -- mod-button2, raise the window to the top of the stack
        , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

        -- mod-button3, set the window to floating mode and resize by dragging
        , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                            >> windows W.shiftMaster))
        ]

      -- Layout Hook
      myLayout = tiled ||| Mirror tiled ||| Full
        where
          -- default tiling algorithm partitions the screen into two panes
          tiled = Tall nmaster delta ratio

          -- the default number of windows in the master pane
          nmaster = 1

          -- default partition of screen occupied by master pane
          ratio = 1/2

          -- percent of screen to increment by when resizing panes
          delta = 3/100


      -- Window Rules
      myManageHook = composeAll
        [ className =? "KeePassXC"          --> doFloat
        , className =? "Picture-in-picture" --> doFloat
        ]

      -- Event Handling
      myEventHook = mempty

      -- Logging
      myLogHook = return ()

      -- Startup Hook
      myStartupHook = do
        spawnOnce "${feh} --no-fehbg --bg-scale ${config.wallpaper}"

      -- }}}

      main = do
        h <- spawnPipe "${xmobar}"
        
        xmonad $ ewmhFullscreen $ ewmh $ docks $ def
          { modMask = myModMask
          , terminal = myTerminal
          , workspaces = myWorkspaces
          , focusFollowsMouse = myFocusFollowsMouse

          -- border
          , borderWidth = myBorderWidth
          , normalBorderColor = myNormalBorderColor
          , focusedBorderColor = myFocusedBorderColor

          -- keybindings
          , keys = myKeys
          , mouseBindings = myMouseBindings

          -- hooks
          , layoutHook = avoidStruts $ spacing 8 $ myLayout
          , manageHook = myManageHook
          , handleEventHook = myEventHook
          , logHook = myLogHook <+> dynamicLogWithPP xmobarPP
              { ppOutput = hPutStrLn h
              , ppCurrent = xmobarColor "#${colors.base0B}" ""
              , ppOrder = \(ws:l:_) -> [ws, l]
              }
          , startupHook = myStartupHook
          }
    '';
  };

  programs.xmobar = {
    enable = true;
    extraConfig = ''
      Config
        { font = "${config.fontProfiles.regular.family} 10"
        , bgColor = "#${colors.base00}"
        , fgColor = "#${colors.base06}"
        , position = Top

        -- border
        , border = FullB
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
  
  home.file.".xinitrc".text = ''
    #!/usr/bin/env bash
    
    exec dbus-run-session xmonad
  '';

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
}
