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
  pname = "nx-window-deco";
  version = "0.1";

  src = "${fetchFromGitHub {
    owner = "re1san";
    repo = "Kde-Dots";
    rev = "mori";
    sha256 = "sha256-Pd4+N4XZdMPULmNdnLeOHbTKTGYb5Av5ed03xspnAXw=";
  }}/window-deco";

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
    qt5.wrapQtAppsHook
  ];

  buildInputs = [
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtx11extras
    plasma-framework
    kdecoration
  ];

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=$(out)"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_TESTING=OFF"
    "-DLIB_INSTALL_DIR=lib"
    "-DKDE_INSTALL_USE_QT_SYS_PATHS=ON"
  ];

  meta = with lib; {
    description = "NX Window Decoration for KDE Plasma";
    homepage = "https://github.com/re1san/Kde-Dots";
    license = licenses.mit;
    maintainers = with maintainers; [shardseven];
  };
}
