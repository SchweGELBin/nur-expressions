{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "MiXBot";
    tag = "v0.2.2";
    hash = "sha256-3yK6mLOJb5Pe16Fzsve5VKccMnBjQhP2p5WMdjucIuo=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
