{
  pname,
  binNames ? [ pname ],
  version,
  src,
}:
{
  lib,
  stdenv,
  plan9port,
  makeWrapper,
}:
let
  binNamesString = lib.concatStringsSep " " binNames;
in
stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [
    plan9port
    makeWrapper
  ];

  buildPhase = ''
    runHook preBuild

    PREFIX=$out make

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    PREFIX=$out make install

    for name in ${binNamesString}; do
      echo "exec ${plan9port}/bin/9 $out/bin/$name \$@" > $out/bin/9$name
      chmod +x $out/bin/9$name
    done

    runHook postInstall
  '';

  meta = {
    description = "";
    homepage = "https://github.com/theobori/9ports";
  };
}
