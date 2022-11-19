{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.vscode;
in
{
  options = {
    modules.vscode = {
      enable = mkEnableOption "Enable vscode";

      hide = mkOption {
        type = types.listOf (types.enum [
          "menu"
          "activity"
          "minimap"
          "scrollbars"
        ]);
        default = [ ];
      };

      theme = mkOption {
        type = types.nullOr types.str;
        default = null;
      };

      vim = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium-fhs;
        userSettings = {
          editor = {
            fontFamily = "'${config.fontProfiles.monospace.family}', monospace";
            fontLigatures = true;
            fontSize = 14;

            renderFinalNewline = false;
          };

          keyboard.dispatch = "keyCode";

          workbench = {
            startupEditor = "none";
            iconTheme = "material-icon-theme";
            colorTheme = mkIf (!isNull cfg.theme) cfg.theme;
          };

          window.menuBarVisibility = mkIf (elem "menu" cfg.hide) "hidden";
          workbench.activityBar.visible = !elem "activity" cfg.hide;
          editor.minimap.enabled = !elem "minimap" cfg.hide;
          editor.scrollbar = mkIf (elem "scrollbars" cfg.hide) {
            horizontal = "hidden";
            vertical = "hidden";
          };

          "[markdown]" = {
            editor.defaultFormatter = "yzhang.markdown-all-in-one";
          };
          "[html]" = {
            editor.defaultFormatter = "esbenp.prettier-vscode";
            editor.tabSize = 2;
          };
          "[css]" = {
            editor.defaultFormatter = "esbenp.prettier-vscode";
            editor.tabSize = 2;
          };
          "[javascript]" = {
            editor.defaultFormatter = "esbenp.prettier-vscode";
            editor.tabSize = 2;
          };
          "[php]" = {
            editor.tabSize = 2;
          };
          "[nix]" = {
            editor.tabSize = 2;
          };

          files.associations = {
            "*.tmpl" = "html";
          };
        };

        extensions = with pkgs.vscode-extensions; [
          # languages support
          jnoortheen.nix-ide
          matklad.rust-analyzer
          golang.go
          ms-python.python
          ms-pyright.pyright
          tamasfe.even-better-toml

          # some useful tools
          esbenp.prettier-vscode
          yzhang.markdown-all-in-one
          donjayamanne.githistory

          # themes
          pkief.material-icon-theme
          jdinhlife.gruvbox
        ];

        mutableExtensionsDir = false;
      };
    }

    (mkIf cfg.vim.enable {
      programs.vscode = {
        userSettings = {
          editor.lineNumbers = "relative";

          vim = {
            easymotion = true;
            incsearch = true;
            hlsearch = true;
            useSystemClipboard = true;
            useCtrlKeys = true;
            leader = "<Space>";
            handleKeys = {
              "<C-b>" = false;
            };
          };
        };
        extensions = [ pkgs.vscode-extensions.vscodevim.vim ];
      };
    })
  ]);
}
