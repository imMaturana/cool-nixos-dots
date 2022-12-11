{ lib,
 ...
}:

with lib;

{
  programs.helix = {
    enable = true;

    settings = {
      theme = mkDefault "gruvbox";

      editor = {
        line-number = "relative";

        lsp = {
          display-messages = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };
      };

      keys.normal = {
        space.f = "file_picker";
      };
    };

    languages = [{
      name = "python";
      language-server = { command = "pyright-langserver"; args = [ "--stdio" ]; };
      config = {};
    }];
  };
}
