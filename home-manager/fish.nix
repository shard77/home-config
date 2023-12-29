{
  inputs,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages;
      }
      {
        name = "async-prompt";
        src = pkgs.fishPlugins.async-prompt;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done;
      }
    ];
  };
}
