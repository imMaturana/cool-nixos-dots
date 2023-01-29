{pkgs, ...}: {
  programs.vscode = {
    userSettings = {
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
