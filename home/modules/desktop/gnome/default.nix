{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.modules.desktop.gnome;
  
  mkBindings = set:
    let
      bindings = mapAttrsToList (binding: command: {
        inherit binding command;
        name = ''Run "${command}"'';
      }) set;
    in listToAttrs (imap0 (i: binding: {
      name = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${toString i}";
      value = binding;
    }) bindings);
in
{
  options = {
    modules.desktop.gnome = {
      enable = mkEnableOption "Enable gnome.";
      
      dark = mkOption {
        type = types.bool;
        default = true;
      };
      
      workspaces = mkOption {
        type = types.enum ([ "dynamic" ] ++ lists.range 1 8);
        default = "dynamic";
      };
      
      bindings = mkOption {
        type = types.attrsOf types.str;
        default = { };
      };
    };
  };
  
  config = 
    let
      bindings = mkBindings cfg.bindings;
    in 
    mkIf cfg.enable {
      home.packages = with pkgs; [
        gnome-console
        amberol
        evince
        gnome-usage
        gnome-text-editor
        gnome.gnome-calculator
        gnome.eog
      ];
  
      nixpkgs.overlays = [(final: prev: {
        keepassxc = final.stable.gnome-secrets;
      })];
  
      dconf = {
        enable = true;
    
        settings = {
          "org/gnome/desktop/background" = {
            primary-color = "#000000";
            secondary-color = "#000000";
            picture-uri = "file://${config.wallpaper}";
            picture-uri-dark = "file://${config.wallpaper}";
          };
    
          "org/gnome/desktop/interface" = {
            monospace-font-name = "${config.fontProfiles.monospace.family} 10";
            color-scheme = if cfg.dark then "prefer-dark" else "light";
          };
        
          "org/gnome/desktop/peripherals/touchpad" = {
            tap-to-click = true;
            two-finger-scrolling-enabled = true;
          };
        
          "org/gnome/mutter" = {
            edge-tiling = true;
            dynamic-workspaces = cfg.workspaces == "dynamic";
          };
          
          "org/gnome/desktop/wm/preferences" = {
            num-workspaces = mkIf (isInt cfg.workspaces) cfg.workspaces;
          };
        
          "org/gnome/settings-daemon/plugins/color" = {
            night-light-enable = true;
            night-light-temperature = "uint32 3500";
            night-light-schedule-automatic = true;
          };
      
          "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = mapAttrsToList (name: _: "/${name}/") bindings;
          };
        } // bindings;
      };

      gtk = {
        enable = true;

        theme = {
          name = if config.modules.desktop.gnome.dark then "adw-gtk3-dark" else "adw-gtk3";
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
          name = if config.modules.desktop.gnome.dark then "adwaita-dark" else "adwaita";
          package = pkgs.adwaita-qt;
        };
      };
      
      fontProfiles.regular = {
        family = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      
      modules = {
        mpv.gnome = true;
      };
    };
}
