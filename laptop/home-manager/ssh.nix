{
  inputs,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      addKeysToAgent yes
      IdentityFile /home/shard/.ssh/id_gitlaptop
    '';
  };
}
