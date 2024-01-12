{
  inputs,
  pkgs,
  ...
}: {
  programs.plasma = {
    enable = true;

    workspace = {
      theme = "breeze-dark";
    };
  };
}
