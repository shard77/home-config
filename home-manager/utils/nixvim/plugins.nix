{pkgs, ...}: let
  enabledPlugins = [
    "nix"
    "nvim-autopairs"
    "telescope"
    "trouble"
    "presence-nvim"
    "nvim-colorizer"
    "flash"
    "lualine"
    "nvim-tree"
    "gitsigns"
    "bufferline"
    "auto-session"
    "barbar"
    "barbecue"
    "navic"
    "luasnip"
    "better-escape"
    "noice"
    #"marks"
    "wilder"
    "diffview"
    "intellitab"
    "multicursors"
    "undotree"
  ];
in {
  imports = [
    ./toggleterm.nix
    ./lsp.nix
    ./completions.nix
    ./folds.nix
  ];

  programs.nixvim = {
    plugins =
      builtins.listToAttrs (map (name: {
          name = name;
          value = {enable = true;};
        })
        enabledPlugins)
      // {
        treesitter = {
          enable = true;
          indent = true;
        };

        oil = {
          enable = true;
          deleteToTrash = true;
        };

        nvim-cmp = {
          enable = true;
          autoEnableSources = true;
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
          ];
        };
        notify = {
          enable = true;
          render = "minimal";
          timeout = 4000;
          topDown = false;
        };
      };
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      popup-nvim

      vim-sleuth
      {
        plugin = tabout-nvim;
        config = ''
          lua require("tabout").setup({
          \   skip_ssl_verification = true,
          \ })
        '';
      }
    ];
  };
}
