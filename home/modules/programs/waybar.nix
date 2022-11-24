{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.waybar;
  
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  mpc = "${pkgs.mpc_cli}/bin/mpc";
  jq = "${pkgs.jq}/bin/jq";
in
{
  options = {
    modules.waybar = {
      enable = mkEnableOption "Enable waybar";

      bars = mkOption {
        type = types.attrsOf (types.submodule {
          options = {
            position = mkOption {
              type = types.enum [ "top" "bottom" ];
              default = "top";
            };

            modules-left = mkOption {
              type = types.listOf types.str;
              default = [ ];
            };

            modules-center = mkOption {
              type = types.listOf types.str;
              default = [ ];
            };

            modules-right = mkOption {
              type = types.listOf types.str;
              default = [ ];
            };
          };
        });
      };
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;

      settings = mapAttrsToList (output: v: {
        inherit output;
        inherit (v)
          position
          modules-left
          modules-center
          modules-right;
        
        layer = "bottom";

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
            default = [ "奄" "奔" "墳" ];
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

        # river only
        "river/tags" = {
          num-tags = 9;
        };
      }) cfg.bars;

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
  };
}

