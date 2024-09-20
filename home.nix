{ pkgs
, username
, inputs
, nix-index-database
, ...
}:
let
  unstable-packages = with pkgs.unstable; [
    bat
    bottom
    coreutils
    curl
    du-dust
    fd
    findutils
    fx
    git
    git-crypt
    htop
    jq
    killall
    mosh
    procs
    ripgrep
    sd
    tmux
    tree
    unzip
    vim
    wget
    zip
  ];

  stable-packages = with pkgs; [
    gh # for bootstrapping
    just

    # core languages
    rustup

    # rust stuff
    cargo-cache
    cargo-expand

    # local dev stuff
    mkcert
    httpie

    # treesitter
    tree-sitter

    # language servers
    nodePackages.vscode-langservers-extracted # html, css, json, eslint
    nodePackages.yaml-language-server
    nil # nix

    # formatters and linters
    alejandra # nix
    deadnix # nix
    nodePackages.prettier
    shellcheck
    shfmt
    statix # nix
  ];

  zjstatus = inputs.zjstatus.packages.${pkgs.system}.default;
in
{
  imports = [
    nix-index-database.hmModules.nix-index
  ];

  home.stateVersion = "24.05";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/fish";
  };

  home.packages =
    stable-packages
    ++ unstable-packages
    ++
    [
      inputs.nixvim.packages.${pkgs.system}.default
      # pkgs.unstable.some-other-package
    ];

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index.enableFishIntegration = true;
    nix-index-database.comma.enable = true;

    starship.enable = true;
    starship.settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;
      git_branch.style = "242";
      directory.style = "blue";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
      python.disabled = true;
      ruby.disabled = true;
      hostname.ssh_only = false;
      hostname.style = "bold green";
    };

    zellij = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        theme = "gruvbox-dark";
      };
    };

    fzf.enableFishIntegration = true;
    lsd.enable = true;
    lsd.enableAliases = true;
    zoxide.enable = true;
    zoxide.enableFishIntegration = true;
    zoxide.options = [ "--cmd cd" ];
    broot.enable = true;
    broot.enableFishIntegration = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    git = {
      enable = true;
      package = pkgs.unstable.git;
      delta.enable = true;
      delta.options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
      };
      userEmail = "sh7user@gmail.com"; # FIXME: set your git email
      userName = "shard77"; #FIXME: set your git username
      extraConfig = {
        # FIXME: uncomment the next lines if you want to be able to clone private https repos
        # url = {
        #   "https://oauth2:${secrets.github_token}@github.com" = {
        #     insteadOf = "https://github.com";
        #   };
        #   "https://oauth2:${secrets.gitlab_token}@gitlab.com" = {
        #     insteadOf = "https://gitlab.com";
        #   };
        # };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        merge = {
          conflictstyle = "diff3";
        };
        diff = {
          colorMoved = "default";
        };
      };
    };

    # FIXME: This is my fish config - you can fiddle with it if you want
    fish = {
      enable = true;
      # FIXME: run 'scoop install win32yank' on Windows, then add this line with your Windows username to the bottom of interactiveShellInit
      # fish_add_path --append /mnt/c/Users/<Your Windows Username>/scoop/apps/win32yank/0.1.1
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

        ${pkgs.lib.strings.fileContents (pkgs.fetchFromGitHub {
            owner = "rebelot";
            repo = "kanagawa.nvim";
            rev = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92";
            sha256 = "sha256-f/CUR0vhMJ1sZgztmVTPvmsAgp0kjFov843Mabdzvqo=";
          }
          + "/extras/kanagawa.fish")}

        set -U fish_greeting
        fish_add_path --append /mnt/c/Users/gess8/Documents/wsl-utils/win32yank
      '';
      functions = {
        refresh = "source $HOME/.config/fish/config.fish";
        take = ''mkdir -p -- "$1" && cd -- "$1"'';
        ttake = "cd $(mktemp -d)";
        show_path = "echo $PATH | tr ' ' '\n'";
        posix-source = ''
          for i in (cat $argv)
            set arr (echo $i |tr = \n)
            set -gx $arr[1] $arr[2]
          end
        '';
      };
      shellAbbrs =
        {
          gc = "nix-collect-garbage --delete-old";
        }
        # navigation shortcuts
        // {
          ".." = "cd ..";
          "..." = "cd ../../";
          "...." = "cd ../../../";
          "....." = "cd ../../../../";
        }
        # git shortcuts
        // {
          gapa = "git add --patch";
          grpa = "git reset --patch";
          gst = "git status";
          gdh = "git diff HEAD";
          gp = "git push";
          gph = "git push -u origin HEAD";
          gco = "git checkout";
          gcob = "git checkout -b";
          gcm = "git checkout master";
          gcd = "git checkout develop";
          gsp = "git stash push -m";
          gsa = "git stash apply stash^{/";
          gsl = "git stash list";
        };
      shellAliases = {
        jvim = "nvim";
        lvim = "nvim";
        pbcopy = "/mnt/c/Windows/System32/clip.exe";
        pbpaste = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -command 'Get-Clipboard'";
        explorer = "/mnt/c/Windows/explorer.exe";
      };
      plugins = [
        {
          inherit (pkgs.fishPlugins.autopair) src;
          name = "autopair";
        }
        {
          inherit (pkgs.fishPlugins.done) src;
          name = "done";
        }
        {
          inherit (pkgs.fishPlugins.sponge) src;
          name = "sponge";
        }
      ];
    };
  };

  xdg.configFile."zellij/plugins/ghost.wasm".source = ./zellij-plugins/ghost.wasm;
  xdg.configFile."zellij/plugins/monocle.wasm".source = ./zellij-plugins/monocle.wasm;
  xdg.configFile."zellij/plugins/harpoon.wasm".source = ./zellij-plugins/harpoon.wasm;
  xdg.configFile."zellij/plugins/room.wasm".source = ./zellij-plugins/room.wasm;
  xdg.configFile."zellij/plugins/zj-docker.wasm".source = ./zellij-plugins/zj-docker.wasm;
  xdg.configFile."zellij/plugins/zellij-forgot.wasm".source = ./zellij-plugins/zellij-forgot.wasm;

  xdg.configFile."zellij/config.kdl".text = ''
    /////////////////////
    // UI & Theme
    /////////////////////
    theme "gruvbox-dark"

    ui {
        pane_frames {
            rounded_corners true
            hide_session_name true
        }
    }

    /////////////////////
    // Options
    /////////////////////
    on_force_close                "quit"
    pane_frames                   true
    session_serialization         true
    pane_viewport_serialization   true
    default_shell                 "fish"
    mouse_mode                    true
    copy_on_select                false
    scrollback_editor             "/usr/bin/vim"
    styled_underlines             true

    // Layouts
    // layout_dir     "/home/th.abel/.config/zellij/layouts"
    default_layout "custom"

    /////////////////////
    // Plugins
    /////////////////////
    plugins {
        tab-bar         { path "tab-bar"; }
        status-bar      { path "status-bar"; }
        strider         { path "strider"; }
        compact-bar     { path "compact-bar"; }
        session-manager { path "session-manager"; }
    }

    /////////////////////
    // Keybinds
    /////////////////////
    // If you'd like to override the default keybindings completely, be sure to change "keybinds" to "keybinds clear-defaults=true"
    keybinds {
        normal {
            bind "Alt c" { Copy; }  // using copy_on_select=false
        }

        locked {
            bind "Ctrl g" { SwitchToMode "Normal"; }
        }

        resize {
            bind "Ctrl n"    { SwitchToMode "Normal"; }
            bind "h" "Left"  { Resize "Increase Left"; }
            bind "j" "Down"  { Resize "Increase Down"; }
            bind "k" "Up"    { Resize "Increase Up"; }
            bind "l" "Right" { Resize "Increase Right"; }
            bind "H"         { Resize "Decrease Left"; }
            bind "J"         { Resize "Decrease Down"; }
            bind "K"         { Resize "Decrease Up"; }
            bind "L"         { Resize "Decrease Right"; }
            bind "=" "+"     { Resize "Increase"; }
            bind "-"         { Resize "Decrease"; }
        }

        pane {
            bind "Ctrl p"    { SwitchToMode "Normal"; }
            bind "h" "Left"  { MoveFocus "Left"; }
            bind "l" "Right" { MoveFocus "Right"; }
            bind "j" "Down"  { MoveFocus "Down"; }
            bind "k" "Up"    { MoveFocus "Up"; }

            bind "p" { SwitchFocus; }
            bind "n" { NewPane; SwitchToMode "Normal"; }
            bind "d" { NewPane "Down"; SwitchToMode "Normal"; }
            bind "r" { NewPane "Right"; SwitchToMode "Normal"; }
            bind "x" { CloseFocus; SwitchToMode "Normal"; }
            bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
            bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
            bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
            bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
            bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0;}
        }

        move {
            bind "Ctrl h"    { SwitchToMode "Normal"; }
            bind "n" "Tab"   { MovePane; }
            bind "p"         { MovePaneBackwards; }
            bind "h" "Left"  { MovePane "Left"; }
            bind "j" "Down"  { MovePane "Down"; }
            bind "k" "Up"    { MovePane "Up"; }
            bind "l" "Right" { MovePane "Right"; }
        }

        tab {
            bind "Ctrl t" { SwitchToMode "Normal"; }
            bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
            bind "h" "Left" "Up" "k" { GoToPreviousTab; }
            bind "l" "Right" "Down" "j" { GoToNextTab; }
            bind "n" { NewTab; SwitchToMode "Normal"; }
            bind "x" { CloseTab; SwitchToMode "Normal"; }
            bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
            bind "b" { BreakPane; SwitchToMode "Normal"; }
            bind "]" { BreakPaneRight; SwitchToMode "Normal"; }
            bind "[" { BreakPaneLeft; SwitchToMode "Normal"; }
            bind "1" { GoToTab 1; SwitchToMode "Normal"; }
            bind "2" { GoToTab 2; SwitchToMode "Normal"; }
            bind "3" { GoToTab 3; SwitchToMode "Normal"; }
            bind "4" { GoToTab 4; SwitchToMode "Normal"; }
            bind "5" { GoToTab 5; SwitchToMode "Normal"; }
            bind "6" { GoToTab 6; SwitchToMode "Normal"; }
            bind "7" { GoToTab 7; SwitchToMode "Normal"; }
            bind "8" { GoToTab 8; SwitchToMode "Normal"; }
            bind "9" { GoToTab 9; SwitchToMode "Normal"; }
            bind "Tab" { ToggleTab; }
        }

        scroll {
            bind "Ctrl s" { SwitchToMode "Normal"; }
            bind "e" { EditScrollback; SwitchToMode "Normal"; }
            bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
            bind "j" "Down" { ScrollDown; }
            bind "k" "Up" { ScrollUp; }
            bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
            bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
            bind "d" { HalfPageScrollDown; }
            bind "u" { HalfPageScrollUp; }
            // uncomment this and adjust key if using copy_on_select=false
            // bind "Alt c" { Copy; }
        }

        search {
            bind "Ctrl s" { SwitchToMode "Normal"; }
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
            bind "j" "Down" { ScrollDown; }
            bind "k" "Up" { ScrollUp; }
            bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
            bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
            bind "d" { HalfPageScrollDown; }
            bind "u" { HalfPageScrollUp; }
            bind "n" { Search "down"; }
            bind "p" { Search "up"; }
            bind "c" { SearchToggleOption "CaseSensitivity"; }
            bind "w" { SearchToggleOption "Wrap"; }
            bind "o" { SearchToggleOption "WholeWord"; }
        }

        entersearch {
            bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
            bind "Enter" { SwitchToMode "Search"; }
        }

        renametab {
            bind "Ctrl c" { SwitchToMode "Normal"; }
            bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
        }

        renamepane {
            bind "Ctrl c" { SwitchToMode "Normal"; }
            bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
        }

        session {
            bind "Ctrl o" { SwitchToMode "Normal"; }
            bind "Ctrl s" { SwitchToMode "Scroll"; }
            bind "d" { Detach; }
            bind "w" {
                LaunchOrFocusPlugin "zellij:session-manager" {
                    floating true
                    move_to_focused_tab true
                };
                SwitchToMode "Normal"
            }
        }

        tmux {
            bind "Ctrl ²" { SwitchToMode "Scroll"; }
            bind "Ctrl b" { Write 2; SwitchToMode "Normal"; }
            bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
            bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
            bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
            bind "c" { NewTab; SwitchToMode "Normal"; }
            bind "," { SwitchToMode "RenameTab"; }
            bind "p" { GoToPreviousTab; SwitchToMode "Normal"; }
            bind "n" { GoToNextTab; SwitchToMode "Normal"; }
            bind "Left" { MoveFocus "Left"; SwitchToMode "Normal"; }
            bind "Right" { MoveFocus "Right"; SwitchToMode "Normal"; }
            bind "Down" { MoveFocus "Down"; SwitchToMode "Normal"; }
            bind "Up" { MoveFocus "Up"; SwitchToMode "Normal"; }
            bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
            bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
            bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
            bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
            bind "o" { FocusNextPane; }
            bind "d" { Detach; }
            bind "Space" { NextSwapLayout; }
            bind "x" { CloseFocus; SwitchToMode "Normal"; }
        }

        shared_except "locked" {
            bind "Ctrl g" { SwitchToMode "Locked"; }
            bind "Ctrl q" { Quit; }
            bind "Alt n" { NewPane; }
            bind "Alt t" { NewTab; }
            bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
            bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
            bind "Alt j" "Alt Down" { MoveFocus "Down"; }
            bind "Alt k" "Alt Up" { MoveFocus "Up"; }
            bind "Alt =" "Alt +" { Resize "Increase"; }
            bind "Alt -" { Resize "Decrease"; }
            bind "Alt [" { PreviousSwapLayout; }
            bind "Alt ]" { NextSwapLayout; }

            // Plugins
            bind "Alt m" {
                LaunchPlugin "file:~/.config/zellij/plugins/monocle.wasm" {
                    in_place true;
                    kiosk    true;
                };
                SwitchToMode "Normal";
            }
            
            bind "Alt (" {
                LaunchOrFocusPlugin "file:~/.config/zellij/plugins/ghost.wasm" {
                    floating true
                    shell "fish"      // required ("bash", "fish", "zsh")
                    shell_flag "-c" // required ("-ic",  "-c",    "-ic")

                    global_completion r#"
                        tf apply -auto-approve
                        cargo build
                        go test -v  ./...
                    "#
                }
            }

            // using GhostLauncher "hack" to pass the cwd=$(pwd) as runtime config
            bind "Alt )" {
                // NOTE: you can pass the global_completion as runtim config with the '\n' delimiter between commands
                Run "fish" "-c" "zellij  plugin --floating --configuration \"shell=fish,shell_flag=-c,exec_cwd=$(pwd),ghost_launcher=GhostLauncher,debug=false,global_completion=tf apply -auto-approve \ncargo build \ngo test -v  ./...\" -- \"file:$HOME/.config/zellij/plugins/ghost.wasm\"" {
                    floating true
                    name "GhostLauncher" // this must match ghost_launcher=GhostLauncher
                                         // the plugin will automatically close the pane
                                         // with title "GhostLauncher"
                }
            }

            bind "Ctrl y" {
                LaunchOrFocusPlugin "file:~/.config/zellij/plugins/harpoon.wasm" {
                    floating true
                    move_to_focused_tab true
                }
            }

            bind "Ctrl x" {
                LaunchOrFocusPlugin "file:~/.config/zellij/plugins/room.wasm" {
                    floating true
                    ignore_case true
                    quick_jump true
                }
            }

            bind "Alt u" {
                LaunchOrFocusPlugin "file:~/.config/zellij/plugins/zellij-forgot.wasm" {
                    "LOAD_ZELLIJ_BINDINGS" "true"
                    floating true
                }
            }

            bind "Alt p" {
                LaunchOrFocusPlugin "file:~/.config/zellij/plugins/zj-docker.wasm" {
                  floating true
                }
            }
        }

        shared_except "normal" "locked" {
            bind "Enter" "Esc" { SwitchToMode "Normal"; }
        }

        shared_except "pane" "locked" {
            bind "Ctrl p" { SwitchToMode "Pane"; }
        }

        shared_except "resize" "locked" {
            bind "Ctrl n" { SwitchToMode "Resize"; }
        }

        shared_except "scroll" "locked" {
            bind "Ctrl s" { SwitchToMode "Scroll"; }
        }

        shared_except "session" "locked" {
            bind "Ctrl o" { SwitchToMode "Session"; }
        }

        shared_except "tab" "locked" {
            bind "Ctrl t" { SwitchToMode "Tab"; }
        }

        shared_except "move" "locked" {
            bind "Ctrl h" { SwitchToMode "Move"; }
        }

        shared_except "tmux" "locked" {
            bind "Ctrl b" { SwitchToMode "Tmux"; }
        }
    }
  '';

  xdg.configFile."zellij/layouts/custom.kdl".text = ''
    layout {
        pane split_direction="vertical" {
            pane
        }

        pane size=1 borderless=true {
            plugin location="file:${zjstatus}/bin/zjstatus.wasm" {
                format_left  "{mode}#[fg=#a89984,bg=#363231] #[fg=#363231,bg=#a89984,italic]{tabs}#[fg=#a89984,bg=#363231]"
                format_right "#[fg=#d5c4a1,bg=#363231]{datetime}#[fg=#a89984,bg=#d5c4a1] #[fg=#363231,bg=#a89984] {session} #[fg=#a89984,bg=#363231]▒░"
                format_space "#[bg=#363231]"

                border_enabled  "true"
                border_char     "─"
                border_format   "#[fg=#b8bb26]{char}"
                border_position "top"

                hide_frame_for_single_pane "true"

                mode_normal        "#[fg=#b8bb26,bg=#363231] #[fg=#363231,bg=#b8bb26]  {name} #[fg=#b8bb26,bg=#363231] "
                mode_locked        "#[fg=#fb4934,bg=#363231] #[fg=#363231,bg=#fb4934]  {name} #[fg=#fb4934,bg=#363231] "
                mode_resize        "#[fg=#d79921,bg=#363231] #[fg=#363231,bg=#d79921]  {name} #[fg=#d79921,bg=#363231] "
                mode_pane          "#[fg=white,bg=#363231] #[fg=#363231,bg=white] 󰓫 {name} #[fg=white,bg=#363231] "
                mode_tab           "#[fg=#fabd2f,bg=#363231] #[fg=#363231,bg=#fabd2f] 󰓩 {name} #[fg=#fabd2f,bg=#363231] "
                mode_scroll        "#[fg=#83a59a,bg=#363231] #[fg=#363231,bg=#83a59a]  {name} #[fg=#83a59a,bg=#363231] "
                mode_enter_search  "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_search        "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_rename_tab    "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_rename_pane   "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_session       "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_move          "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_prompt        "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "
                mode_tmux          "#[fg=white,bg=#363231] #[fg=#363231,bg=white] {name} #[fg=white,bg=#363231] "

                tab_normal   "#[fg=#363231,bg=#a89984,italic] {name} "
                tab_active   "#[fg=#ebdbb2,bg=#a89984,bold]#[fg=#363231,bg=#ebdbb2,bold]{index}  {name}#[fg=#ebdbb2,bg=#a89984,bold]"

                command_git_branch_command   "git rev-parse --abbrev-ref HEAD"
                command_git_branch_format    "#[fg=blue] {stdout} "
                command_git_branch_interval  "10"

                datetime        "#[fg=#363231,bg=#d5c4a1]󰃭 {format}"
                datetime_format "%d/%m/%Y"
                datetime_timezone "Europe/Paris"
            }
        }
    }
  '';
}
