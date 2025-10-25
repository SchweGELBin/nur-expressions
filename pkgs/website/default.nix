{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.3";
    hash = "sha256-OUxvO9/OZx+yto58p+n6anSloa7RrJzagXMJ1QImbwI=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
