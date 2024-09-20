{
  programs.nixvim.plugins = {
    luasnip = {
      enable = true;
      extraConfig = {
        enable_autosnippets = false;
        sotre_selection_keys = "<Tab>";
      };
    };
    nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      preselect = "None";
      matching.disallowPartialFuzzyMatching = false;
      snippet.expand = "luasnip";
      window = {
        completion.scrollbar = false;
        completion.scrolloff = 2;
      };
      sources = [
        {name = "nvim_lsp";}
        {name = "luasnip";}
        {name = "calc";}
        {name = "emoji";}
        {name = "treesitter";}
        {name = "nerdfont";}
        {name = "git";}
        {name = "fuzzy-path";}
        {name = "path";}
        {name = "buffer";}
      ];
    };
  };
}
