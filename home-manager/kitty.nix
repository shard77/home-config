{
  inputs,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.8";
      background_blur = "1";
      font_size = "14.0";
    };
  };
}
