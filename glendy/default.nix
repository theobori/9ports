{
  pkgs,
  face,
}:
let
  f = import ../mk9Port.nix {
    pname = "glendy";
    version = "0.0.1";
    src = ./.;
    additionalMakeEnvVars = {
      FACE_DIR = "${face}/share/face";
    };
  };
in
pkgs.callPackage f { }
