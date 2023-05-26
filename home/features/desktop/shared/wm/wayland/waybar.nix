{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) optionals getExe;

  pamixer = getExe pkgs.pamixer;
  mpc = getExe pkgs.mpc_cli;
  jq = getExe pkgs.jq;
in {
  programs.waybar = {
    enable = true;

    settings = [
      {
        output = config.home.primaryMonitor.name;
        position = "top";
        layer = "top";

        modules-left =
          optionals config.wayland.windowManager.sway.enable [
            "custom/scratchpad"
            "sway/workspaces"
            "sway/mode"
          ]
          ++ optionals config.wayland.windowManager.hyprland.enable [
            "hyprland/window"
          ];

        modules-right = [
          "tray"
          "idle_inhibitor"
          "pulseaudio"
          "battery"
          "network"
          "clock"
        ];

        "tray" = {
          icon-size = 16;
          spacing = 8;
        };

        "network" = {
          format = "🐑 {essid}";
          format-disconnect = "Disconnected";
          format-alt = "⬆️ {bandwidthUpBits} ⬇️ {bandwidthDownBits}";
          tooltip-format = "{ifname}";
          max-length = 40;
          interval = 1;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "🔓";
            deactivated = "🔒";
          };
        };

        "pulseaudio" = {
          format = "🐹 {volume}%";
          format-muted = "🐹 Muted";
          format-icons = {
            default = ["奄" "奔" "墳"];
          };
          on-click = "${pamixer} -t";
          on-click-right = "${pamixer} --default-source -t";
          scroll-step = 0.1;
        };

        "battery" = {
          format = "🐻 {capacity}%";
          format-plugged = "🐻 {capacity}%";
          interval = 5;
          states = {
            warning = 30;
            critical = 15;
          };
          max-length = 25;
        };

        "clock" = {
          format = "🐢 {:%H:%M}";
          format-alt = "🐢 {:%a, %d %b %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<small>{calendar}</small>";
        };

        "mpd" = {
          format = "{stateIcon} {artist} - {title}";
          format-disconnected = "ﱙ";
          format-stopped = " Stopped";
          state-icons = {
            paused = "";
            playing = "";
          };
          max-length = 40;
          interval = 1;
          on-click = "${mpc} toggle";
          on-click-right = "${mpc} stop";
          on-scroll-up = "${mpc} volume +1";
          on-scroll-down = "${mpc} volume -1";
        };

        # sway only
        "sway/workspaces" = {
          format = "{name}";
        };

        "custom/scratchpad" = {
          interval = 1;
          exec = "swaymsg -t get_tree | ${jq} 'recurse(.nodes[]) | first(select(.name==\"__i3_scratch\")) | .floating_nodes | length'";
          format = "  {}";
          tooltip = false;
          on-click = "swaymsg 'scratchpad show'";
          on-click-right = "swaymsg 'move scratchpad'";
        };

        # hyprland
        "hyprland/window" = {
          format = "{}";
        };

        # river only
        "river/tags" = {
          num-tags = 9;
        };
      }
    ];

    style = with config.colorscheme.colors; ''
      /* reset */
      * {
        padding: 0;
        margin: 0;
        min-height: 0;
      }

      button {
        min-width: 1.5em;
      }

      /* waybar */
      window#waybar {
        font-family: '${config.fontProfiles.monospace.family}';
        font-size: 1.25em;
        background: #${base00};
        color: #${base06};
      }

      /* defaults */
      widget box,
      widget > label {
        padding: 0.25em 0.5em;
      }

      .modules-right widget:nth-child(even) {
        background: #${base0D};
        color: #${base00};
      }

      /* workspaces / tags */
      #workspaces button,
      #tags button {
        background: none;
        color: #${base02};
        font-weight: bold;
      }

      #tags button.occupied {
        color: #${base06};
      }

      #workspaces button.focused,
      #tags button.focused {
        color: #${base0D};
      }

      #workspace button.urgent,
      #tags button.urgent {
        color: #${base08};
      }

      #workspaces button:hover,
      #tags button:hover {
        color: #${base0B};
      }

      /* mpd */
      #mpd.disconnected {
        opacity: 0;
      }

      /* tray */
      #tray {
        margin-left: 1em;
        margin-right: 1em;
      }
    '';
  };
}
