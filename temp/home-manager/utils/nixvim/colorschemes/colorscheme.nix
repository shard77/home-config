{
  programs.nixvim.colorschemes = {
    rose-pine = {
      enable = false;
      style = "main"; #  "main", "moon", "dawn" or raw lua code
      disableItalics = false;
      transparentFloat = true;
      transparentBackground = true;
    };
    catppuccin = {
      enable = true;
      background = {
        light = "macchiato";
        dark = "mocha";
      };
      flavour = "mocha"; # "latte", "mocha", "frappe", "macchiato" or raw lua code
      disableBold = false;
      disableItalic = false;
      disableUnderline = false;
      transparentBackground = true;
      integrations = {
        cmp = true;
        noice = true;
        notify = true;
        neotree = true;
        harpoon = true;
        gitsigns = true;
        which_key = true;
        illuminate = {
          enabled = true;
        };
        treesitter = true;
        treesitter_context = true;
        telescope.enabled = true;
        indent_blankline.enabled = true;
        mini.enabled = true;
        native_lsp = {
          enabled = true;
          inlay_hints = {
            background = true;
          };
          underlines = {
            errors = ["underline"];
            hints = ["underline"];
            information = ["underline"];
            warnings = ["underline"];
          };
        };
      };
    };
  };
}
