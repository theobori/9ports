import ./mk9Port.nix {
  pname = "9ports";
  version = "0.0.1";
  src = ./.;
  binNames = [
    "sudoku"
    "catclock"
    "juggle"
    "festoon"
  ];
}
