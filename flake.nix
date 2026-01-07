{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        default = pkgs.callPackage ./. { };
        face = pkgs.callPackage ./face { };
      in
      {
        packages = {
          inherit default face;
          all = default;
          sudoku = pkgs.callPackage ./sudoku { };
          catclock = pkgs.callPackage ./catclock { };
          juggle = pkgs.callPackage ./juggle { };
          festoon = pkgs.callPackage ./festoon { };
          sokoban = pkgs.callPackage ./sokoban { };
          mahjongg = pkgs.callPackage ./mahjongg { };
          life = pkgs.callPackage ./life { };
          xs = pkgs.callPackage ./xs { };
          memo = pkgs.callPackage ./memo { inherit face; };
          glendy = pkgs.callPackage ./glendy { inherit face; };
        };

        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              plan9port
            ];
          };
        };

        formatter = treefmtEval.config.build.wrapper;

        checks = {
          formatting = treefmtEval.config.build.check self;
        };
      }
    );
}
