{
  pkgs,
  inputs,
  ...
}: {
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
    helix
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
    btop
    eza
    zip
    file
    unzip
    zoxide
    bat
    zellij
    inotify-tools
    manix
    yazi
    ripgrep
    gimp
    networkmanagerapplet

    inputs.nixvim-custom.packages.${system}.default

    # hyprland pkgs
    bun
    dart-sass
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
    pyprland

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
