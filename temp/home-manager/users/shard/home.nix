{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  homeDirectory = "/home/shard";
in {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    # You can also split up your configuration and import pieces of it here:

    ../../wm-stuff/hyprland
    ../../wm-stuff/ags.nix
    ../../themes/theme.nix
    ../../utils/lf.nix
    ../../utils/dconf.nix
    ../../utils/zoxide.nix
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

  gtk.gtk3.bookmarks = [
    "file://${homeDirectory}/Documents"
    "file://${homeDirectory}/Music"
    "file://${homeDirectory}/Pictures"
    "file://${homeDirectory}/Videos"
    "file://${homeDirectory}/Downloads"
    "file://${homeDirectory}/Desktop"
    "file://${homeDirectory}/Projects"
    "file://${homeDirectory}/Vault"
    "file://${homeDirectory}/Vault/School"
    "file://${homeDirectory}/.config Config"
    "file://${homeDirectory}/.local/share Local"
  ];

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
