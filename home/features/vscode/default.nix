{ pkgs
, lib
, config
, ...
}:
with lib; {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    userSettings = {
      editor = {
        fontFamily = "'${config.home.fonts.monospace.family}', monospace";
        fontLigatures = true;
        fontSize = 14;

        renderFinalNewline = false;
      };

      keyboard.dispatch = "keyCode";

      workbench = {
        startupEditor = "none";
        iconTheme = "material-icon-theme";
      };

      window.menuBarVisibility = mkDefault "toggle";

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
