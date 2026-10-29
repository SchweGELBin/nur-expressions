{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.7.0";
    hash = "sha256-jf/kNsumIDidP/kmt93BRhRlHaR1TfBnpl8nyOJHyw0=";
  };
in

pkgs.callPackage src { }
