{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.4.1";
    hash = "sha256-x/TpP01ziNr+uZwlk9abE+A18kccXuBQPGT9zBbDQzk=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
