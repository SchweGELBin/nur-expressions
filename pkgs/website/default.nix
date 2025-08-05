{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.1.0";
    hash = "sha256-Nr6x+pz+o+KUvmu7IsZse35OyIaAEVRkSFgILLZeK3k=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
