{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
    # You can also split up your configuration and import pieces of it here:

    ../../wm-stuff/hyprland
    ../../wm-stuff/ags
    ../../themes/theme.nix
    ../../utils/lf.nix
    ../../utils/dconf.nix
    ../../utils/zoxide.nix
    ../../utils/nixvim
    ../../terminal/yazi.nix
    ../../terminal/git
    ../../terminal/fish
    ../../terminal/kitty
    ../../terminal/starship
    ../../browsers/firefox
    ../../packages/mixed
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "shard";
    homeDirectory = "/home/shard";
  };

  programs.home-manager.enable = true;

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
