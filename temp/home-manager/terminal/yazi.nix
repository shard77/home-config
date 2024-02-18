{
  inputs,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };
}
