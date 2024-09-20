{
  lib,
  stdenv,
  fetchzip,
  jre,
  giflib,
  gawk,
  runtimeShell,
}:
stdenv.mkDerivation rec {
  pname = "maltego";
  version = "4.6.0";
  src = fetchzip {
    url = "https://downloads.maltego.com/maltego-v4/linux/Maltego.v${version}.linux.zip";
    hash = "sha256-q+1RYToZtBxAIDSiUWf3i/3GBBDwh6NWteHiK4VM1HY=";
  };

  preConfigure = ''
    for awks in bin/maltego; do
        substituteInPlace $awks \
              --replace /usr/bin/awk ${gawk}/bin/awk
    done
  '';

  buildInputs = [jre giflib];

  installPhase = ''
    mkdir -p "$out/bin"
    mkdir -p "$out/share"
    cp -aR . "$out/share/${pname}/"
    cat > "$out/bin/${pname}" << EOF
    #!${runtimeShell}
    export PATH="${lib.makeBinPath [jre]}:\$PATH"
    export JAVA_HOME='${jre}'
    exec "$out/share/${pname}/bin/${pname}" "\$@"
    EOF

    chmod u+x  "$out/bin/${pname}"
  '';

  meta = with lib; {
    homepage = "https://www.maltego.com";
    description = "An open source intelligence and forensics application, enabling to easily gather information about DNS, domains, IP addresses, websites, persons, and so on";
    maintainers = with maintainers; [d3vil0p3r];
    platforms = platforms.linux;
    license = licenses.gpl2;
  };
}
