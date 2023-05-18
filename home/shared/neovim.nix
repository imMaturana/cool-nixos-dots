{
  pkgs,
  config,
  ...
}:
let
  inherit (config.colorscheme) colors;
in {
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

    maps = {
      normal = {
        # switch between buffers
        "<C-j>" = {
          action = ":bnext<CR>";
          noremap = true;
          silent = true;
        };
        "<C-k>" = {
          action = ":bprev<CR>";
          noremap = true;
          silent = true;
        };
      };
    };

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
        enable = true; # https://github.com/pta2002/nixvim/issues/20
        nixGrammars = true;
      };

      lsp = {
        enable = true;
        servers = {
          rnix-lsp.enable = true;
          rust-analyzer.enable = true;
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
        sources = [{name = "nvim_lsp";}];
        mappingPresets = ["insert"];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
        formatting.fields = ["kind" "abbr" "menu"];
      };

      lsp-lines.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-go
      julia-vim

      # themes
      {
        plugin = nvim-base16;
        config = ''
          lua << EOF
          require("base16-colorscheme").with_config {
            telescope = false,
          }

          local colorscheme = require('colorscheme')
          colorscheme.setup({
            base00 = '#${colors.base00}',
            base01 = '#${colors.base01}',
            base02 = '#${colors.base02}',
            base03 = '#${colors.base03}',
            base04 = '#${colors.base04}',
            base05 = '#${colors.base05}',
            base06 = '#${colors.base06}',
            base07 = '#${colors.base07}',
            base08 = '#${colors.base08}',
            base09 = '#${colors.base09}',
            base0A = '#${colors.base0A}',
            base0B = '#${colors.base0B}',
            base0C = '#${colors.base0C}',
            base0D = '#${colors.base0D}',
            base0E = '#${colors.base0E}',
            base0F = '#${colors.base0F}'
          })
          EOF
        '';
      }
    ];
  };

  home.sessionVariables.EDITOR = "nvim";
}
