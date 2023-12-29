{
  inputs,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "shard";
    userEmail = "sh7user@gmail.com";
  };
}
