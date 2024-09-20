{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  extra-cmake-modules,
  qt5,
  kdecoration,
  plasma-framework,
  wrapQtAppsHook,
}:
stdenv.mkDerivation rec {
  pname = "mori-desktop-theme";
  version = "1.0";

  src = "${fetchFromGitHub {
    owner = "re1san";
    repo = "Kde-Dots";
    rev = "mori";
    sha256 = "sha256-Pd4+N4XZdMPULmNdnLeOHbTKTGYb5Av5ed03xspnAXw=";
  }}/plasma/desktoptheme/";

  installPhase = ''
    mkdir -p $out/share/plasma/desktoptheme
    cp -r $src/* $out/share/plasma/desktoptheme/
  '';

  meta = with lib; {
    description = "Mori Desktop Theme For KDE Plasma";
    homepage = "https://github.com/re1san/Kde-Dots";
    license = licenses.mit;
    maintainers = with maintainers; [shardseven];
  };
}
