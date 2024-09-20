{pkgs, ...}: {
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      direction = "float";
      openMapping = "<M-n>";
      floatOpts.border = "curved";
    };
    extraConfigLuaPre = ''
      local Terminal = require('toggleterm.terminal').Terminal
    '';
  };
}
