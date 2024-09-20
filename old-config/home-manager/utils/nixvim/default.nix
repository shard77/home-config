{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./options.nix
    ./keymaps.nix
    ./theme.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
  };
}
