{
  inputs,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "shard";
    userEmail = "sh7user@gmail.com";
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
    };
  };
}
