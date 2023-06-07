{ pkgs
, lib
, config
, ...
}:
with lib; let
  cfg = config.desktopEnvironment.gnome;

  bindings =
    let
      bindingsList =
        mapAttrsToList
          (binding: command: {
            inherit binding command;
            name = ''Run "${command}"'';
          })
          cfg.bindings;
    in
    listToAttrs (imap0
      (i: binding: {
        name = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${toString i}";
        value = binding;
      })
      bindingsList);
in
{
  options = {
    desktopEnvironment.gnome = {
      enable = mkEnableOption "Enable Gnome configuration";

      themeVariant = mkOption {
        type = types.enum [ "light" "dark" ];
        default = "light";
        defaultText = literalExpression "light";
      };

      monospaceFont = mkOption {
        type = types.nullOr (types.submoudule {
          options = {
            family = mkOption {
              type = types.str;
            };

            size = mkOption {
              type = types.float;
            };
          };
        });
        default = null;
      };

      wallpaper = mkOption {
        type = types.nullOr types.path;
        default = null;
      };

      bindings = mkOption {
        type = types.attrsOf types.str;
        default = { };
        defaultText = literalExpression "{ }";
        example = literalExpression ''
          {
            "<Ctrl><Alt>T" = "kgx";
          }
        '';
      };

      workspaces = mkOption {
        type = types.enum ([ "dynamic" ] ++ lists.range 1 8);
        default = "dynamic";
        defaultText = literalExpression "dynamic";
      };

      nightLight = mkOption {
        type = types.submodule {
          options = {
            enable = mkEnableOption "Enable night light";

            temperature = mkOption {
              type = types.int;
              default = 4000;
              defaultText = literalExpression "4000";
            };
          };
        };
        default = { };
        defaultText = literalExpression "{ }";
        example = literalExpression ''
          {
            enable = true;
            temperature = 3800;
          }
        '';
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      dconf = {
        enable = true;

        settings = {
          "org/gnome/desktop/background" = rec {
            primary-color = "#000000";
            secondary-color = "#000000";
            picture-uri = mkIf (!isNull cfg.wallpaper) "file://${cfg.wallpaper}";
            picture-uri-dark = picture-uri;
          };

          "org/gnome/desktop/interface" = {
            monospace-font-name =
              mkIf (!isNull cfg.monospaceFont)
                "${cfg.monospaceFont.family} ${toString cfg.monospaceFont.size}";
            color-scheme =
              if cfg.themeVariant == "light"
              then "light"
              else "prefer-dark";
          };

          "org/gnome/settings-daemon/peripherals" = {
            tap-to-click = true;
            natural-scroll = true;
          };

          "org/gnome/mutter" = {
            edge-tiling = true;
            dynamic-workspaces = cfg.workspaces == "dynamic";
          };

          "org/gnome/desktop/wm/preferences" = {
            num-workspaces = mkIf (isInt cfg.workspaces) cfg.workspaces;
          };

          "org/gnome/settings-daemon/plugins/color" = {
            night-light-enable = cfg.nightLight.enable;
            night-light-temperature = "uint32 ${toString cfg.nightLight.temperature}";
          };
        };
      };

      gtk = {
        enable = true;

        theme = {
          name =
            if cfg.themeVariant == "light"
            then "adw-gtk3"
            else "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };

        iconTheme = {
          name = "Adwaita";
          package = pkgs.gnome.adwaita-icon-theme;
        };
      };

      qt = {
        enable = true;
        platformTheme = "gnome";
        style = {
          name =
            if cfg.themeVariant == "light"
            then "adwita"
            else "adwaita-dark";
          package = pkgs.adwaita-qt;
        };
      };

      services = {
        gpg-agent.pinentryFlavor = "gnome3";
      };
    }

    (mkIf (bindings != { }) {
      dconf.settings =
        {
          "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = mapAttrsToList (n: _: "/${n}/") bindings;
          };
        }
        // bindings;
    })
  ]);
}
