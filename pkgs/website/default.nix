{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.4.0";
    hash = "sha256-iAqcAFVYJFBY1ZEr58DxEQD7+MlvpHYSLUvMiR5/5rI=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
