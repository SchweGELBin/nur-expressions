{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.6";
    hash = "sha256-o1nrhHK6P1S1pt/CuwZ/BZwnHMz/r5zjF0ikR2PpMBI=";
  };
in

pkgs.callPackage src { }
