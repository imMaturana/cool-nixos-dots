{config, ...}: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "base16-${config.colorscheme.slug}";

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

    themes."base16-${config.colorscheme.slug}" = import ./theme.nix {
      colors = config.colorscheme.colors;
    };
  };
}
