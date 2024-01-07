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

    firefox
    kitty
    fish
    neofetch
    armcord
    keepassxc
    unstable.vscode
    openssh
    starship
    icon-library
    dconf-editor
    d-spy
    # audio
    (mpv.override {scripts = [mpvScripts.mpris];})

    # tools
    eza
    zip
    file
    unzip
    zoxide
    bat
    zellij
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
    copyq

    # langs
    gcc
    gnumake
    unstable.nodejs
    pnpm
    typescript
    eslint
    nil
    deadnix
    statix
  ];
}
