{
  pname,
  version,
  src,
  mainProgram ? "9" + pname,
}:
{
  lib,
  stdenv,
  plan9port,
}:
stdenv.mkDerivation {
  inherit pname version src;

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

        for name in $(ls $out/bin); do
          mv $out/bin/$name $out/bin/.$name

          src=$out/bin/.$name
          dst=$out/bin/9$name

          # She shebang will be automatically patched by Nix
          cat <<EOF > $dst
    #!/usr/bin/env sh
    exec ${plan9port}/bin/9 $src \$@
    EOF
          chmod +x $dst
        done

        runHook postInstall
  '';

  meta = {
    description = "";
    homepage = "https://github.com/theobori/9ports";
  }
  // lib.optionalAttrs (mainProgram != null) {
    inherit mainProgram;
  };
}
