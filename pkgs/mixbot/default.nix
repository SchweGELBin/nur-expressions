{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "MiXBot";
    tag = "v1.0.0";
    hash = "sha256-bVTBjxksVllyRXltU086IF0fa4Y7Xlx+EO9J2+0Rano=";
  };
in

pkgs.callPackage src { }
