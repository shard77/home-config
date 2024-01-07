{
  inputs,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.6";
      background_blur = "1";
      font_size = "14.0";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = "never";
      confirm_os_window_close = "0";
    };
  };
}
