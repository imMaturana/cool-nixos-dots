{ pkgs, ... }: {
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

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };
}
