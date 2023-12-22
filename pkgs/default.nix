# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  nx-clock-applet = pkgs.callPackage ./nx-clock-applet.nix {
    inherit (pkgs) stdenv cmake extra-cmake-modules qt5;
    plasma-framework = pkgs.libsForQt5.plasma-framework;
    wrapQtAppsHook = pkgs.libsForQt5.wrapQtAppsHook;
    kdecoration = pkgs.libsForQt5.kdecoration;
  };
}
