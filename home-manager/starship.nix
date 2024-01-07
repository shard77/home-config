{
  inputs,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = "$os$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$python$character";
      directory = {
        style = "bold blue";
        read_only = " 󰌾";
        home_symbol = "";
      };
      character = {
        success_symbol = "[❯](blue)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      username = {
        disabled = false;
        show_always = true;
        style_user = "blue";
        style_root = "white";
      };
      c = {
        format = "\[[$symbol($version(-$name))]($style)\]";
        symbol = " ";
      };
      os = {
        disabled = false;
        style = "bold bright-blue";
        symbols = {
          NixOS = " ";
        };
      };
    };
  };
}
