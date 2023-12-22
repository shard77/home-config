# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
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

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
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
  programs.neovim.enable = true;

  programs = {
    git = {
      enable = true;
      userName = "shard";
      userEmail = "sh7user@gmail.com";
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = "$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$python$character";
        directory = {
          style = "blue";
        };
        character = {
          success_symbol = "[❯](blue)";
          error_symbol = "[❯](red)";
          vimcmd_symbol = "[❮](green)";
        };
        git_branch = {
          format = "[$branch]($style)";
          style = "bright-black";
        };
        git_status = {
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "";
          untracked = "";
          modified = "";
          staged = "";
          renamed = "";
          deleted = "";
          stashed = "≡";
        };
        git_state = {
          format = "\([$state( $progress_current/$progress_total)]($style)\) ";
          style = "bright-black";
        };
        cmd_duration = {
          format = "[$duration]($style)";
          style = "blue";
        };
        python = {
          format = "[$virtualenv]($style)";
          style = "bright-black";
        };
      };
    };
    fish = {
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
    kitty = {
      enable = true;
      settings = {
        background_opacity = "0.8";
        background_blur = "1";
      };
    };
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        rust-lang.rust-analyzer
        github.copilot
        github.copilot-chat
        astro-build.astro-vscode
        pkief.material-icon-theme
        serayuzgur.crates
        equinusocio.vsc-material-theme
        esbenp.prettier-vscode
        ms-python.python
        ms-python.vscode-pylance
        bradlc.vscode-tailwindcss
      ];
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
