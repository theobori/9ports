{
  lib,
  stdenv,
  plan9port,
}:
stdenv.mkDerivation {
  pname = "9ports";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = [
    plan9port
  ];

  buildPhase = ''
    runHook preBuild

    PREFIX=$out make

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    PREFIX=$out make install

    runHook postInstall
  '';

  meta = {
    description = "";
    homepage = "https://github.com/theobori/9ports";
  };
}
