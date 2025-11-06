{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.5";
    hash = "sha256-kGU3+INy9qUcMWT8BHIx9fHD2Ej3SwieqN1yWz/0+QA=";
  };
in

pkgs.callPackage src { }
