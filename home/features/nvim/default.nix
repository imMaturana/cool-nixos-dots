{ pkgs
, config
, ...
}: {
  programs.nixvim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    options = {
      number = true;
      relativenumber = true;

      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;

      laststatus = 3;

      termguicolors = true;
    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      # switch between buffers
      {
        mode = "n";
        key = "<C-j>";
        action = ":bnext<CR>";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = ":bprev<CR>";
      }
    ];

    plugins = {
      bufferline.enable = true;
      lualine = {
        enable = true;
        theme = "base16";
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
        };
      };

      nvim-tree = {
        enable = false;
        filters.custom = [
          ".git"
        ];
      };

      nix.enable = true;
      zig.enable = true;
      emmet.enable = true;
      treesitter = {
        enable = true;
        nixGrammars = true;
      };

      lsp = {
        enable = true;
        servers = {
          rnix-lsp.enable = true;
          rust-analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
          pyright.enable = true;
          zls.enable = true;
          gopls.enable = true;
          elixirls.enable = true;
        };
      };

      lspkind = {
        enable = true;
        cmp.ellipsisChar = "...";
        cmp.menu = {
          buffer = "[Buffer]";
          nvim_lsp = "[LSP]";
          luasnip = "[LuaSnip]";
          nvim_lua = "[Lua]";
          latex_symbols = "[Latex]";
        };
        cmp.after = ''
          function(entry, vim_item, kind)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "   " .. strings[2]
            return kind
          end
        '';
      };

      nvim-cmp = {
        enable = true;
        sources = [{ name = "nvim_lsp"; }];
        mappingPresets = [ "insert" ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
        formatting.fields = [ "kind" "abbr" "menu" ];
      };

      lsp-lines.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins;
      [
        vim-go
        julia-vim
      ]
      ++ [
        (import ./theme.nix {
          plugin = nvim-base16;
          colors = config.colorscheme.colors;
        })
      ];
  };

  home.sessionVariables.EDITOR = "nvim";
}
