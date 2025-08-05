{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.1.1";
    hash = "sha256-KiH0SLRJKE4w++q8Utzo/AmOQ/uUMyPMR7CfVvq+KTE=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
