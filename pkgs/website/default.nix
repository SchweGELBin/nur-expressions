{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.2.0";
    hash = "sha256-S68Yi2xNJvjDs/tSlzjjD7G9/Bt0t9YLBDPEND2NvT8=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
