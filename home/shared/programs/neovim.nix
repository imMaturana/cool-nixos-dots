{
  pkgs,
  config,
  ...
}: {
  programs.nixvim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    colorscheme = "base16-${config.colorscheme.slug}";

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
        "<C-b>" = {
          action = ":NvimTreeToggle<CR>";
          noremap = true;
          silent = true;
        };

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

        "<leader>ff" = {
          action = ''<cmd>lua require("telescope.builtin").find_files()<CR>'';
          noremap = true;
        };
        "<leader>fg" = {
          action = ''<cmd>lua require("telescope.builtin").live_grep()<CR>'';
          noremap = true;
        };
        "<leader>fb" = {
          action = ''<cmd>lua require("telescope.builtin").buffers()<CR>'';
          noremap = true;
        };
        "<leader>fh" = {
          action = ''<cmd>lua require("telescope.builtin").help_tags()<CR>'';
          noremap = true;
        };
      };
    };

    plugins = {
      bufferline.enable = true;
      lualine = {
        enable = true;
        theme = "base16";
      };
      goyo.enable = true;
      telescope.enable = true;

      nvim-tree = {
        enable = true;
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
        };
      };

      coq-nvim = {
        enable = true; # broken
        installArtifacts = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-go
      julia-vim

      # git
      diffview-nvim

      # themes
      nvim-base16
    ];
  };

  home.sessionVariables.EDITOR = "nvim";
}
