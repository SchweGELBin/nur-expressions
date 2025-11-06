{ fetchFromGitHub, pkgs }:
let
  pin = import ./pin.nix;
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "smoos";
    tag = pin.version;
    hash = pin.hash;
  };
in

pkgs.callPackage "${src}/smoos-bot" { }
