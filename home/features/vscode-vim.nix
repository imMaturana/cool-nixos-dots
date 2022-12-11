{pkgs, ...}: {
  imports = [./vscode.nix];

  programs.vscode = {
    userSettings = {
      window = {
        menuBarVisibility = "hidden";
      };

      workbench = {
        activityBar.visible = false;
      };

      editor = {
        lineNumbers = "relative";

        minimap.enabled = false;
        scrollbar = {
          horizontal = "hidden";
          vertical = "hidden";
        };
      };

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

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };
}
