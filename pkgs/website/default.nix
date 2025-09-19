{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.5.1";
    hash = "sha256-2M6eeKIRi1Rcz1q6j0wvGc8b2jYx4bim/nup+smHe8w=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
