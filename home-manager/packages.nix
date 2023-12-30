{pkgs, ...}: {
  xdg.desktopEntries = {
    "lf" = {
      name = "lf";
      noDisplay = true;
    };
  };

  home.packages = with pkgs;
  with nodePackages_latest;
  with gnome; [
    (import ./colorscript.nix {inherit pkgs;})

    brave
    kitty
    fish
    neofetch
    armcord
    keepassxc
    # unstable.vscode
    openssh
    starship
    icon-library
    dconf-editor
    d-spy

    # audio
    (mpv.override {scripts = [mpvScripts.mpris];})

    # tools
    eza
    bat
    inotify-tools

    # hyprland pkgs
    wl-gammactl
    wl-clipboard
    wf-recorder
    hyprpicker
    wayshot
    swappy
    slurp
    imagemagick
    pavucontrol
    brightnessctl
    swww

    # langs
    gcc
    gnumake
    nodejs
    typescript
    eslint
    nil
    deadnix
    statix
  ];
}
