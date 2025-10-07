{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.1";
    hash = "sha256-XDAEOzSuAufDYtt6NRJZGcFpaTet/AdpUJvA0QJeews=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
