{
  inputs,
  pkgs,
  ...
}: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      default_shell = "fish";
      theme = "catppucin-mocha";

      themes = {
        catppucin-mocha = {
          bg = "#585b70";
          fg = "#cdd6f4";
          red = "#f38ba8";
          # green = "#a6e3a1";
          green = "#89b4fa";
          blue = "#89b4fa";
          yellow = "#f9e2af";
          magenta = "#f5c2e7";
          orange = "#fab387";
          cyan = "#89dceb";
          black = "#181825";
          white = "#cdd6f4";
        };
      };
    };
  };
}
