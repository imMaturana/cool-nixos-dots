{config, inputs, ...}: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "base16";

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

    languages = [
      {
        name = "python";
        language-server = {
          command = "pyright-langserver";
          args = ["--stdio"];
        };
        config = {};
      }
    ];
    
    themes."base16" = builtins.fromTOML (builtins.readFile
      "${inputs.base16-helix}/themes/base16-${config.colorscheme.slug}.toml");
  };
}
