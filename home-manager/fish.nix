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
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair;
      }
    ];
    functions = {
      cheat = {
        description = "Adds an alias for cheat.sh";
        body = ''
          curl "cheat.sh/$argv?style=native"
        '';
      };
    };
    shellAliases = {
      la = "eza -1 --icons --group-directories-first --grid --long --no-time --group --all";
      ls = "eza -1 --icons --group-directories-first --grid";
      l = "eza --git --icons --group-directories-first --long --group --all";
      c = "bat";
      cat = "bat";
      catp = "bat --plain";
      cd = "z";
      cl = "clear";
      mkdir = "mkdir -p $1";
      nixconf = "cd /etc/nixos/";
      athpkg = "cd /home/shard/Documents/athena-packages/";
      copyfile = "copyq copy - < $1";
      copypath = "copyq copy '$(pwd)'";
      pastefile = "copy clipboard > $1";
    };
  };
}
