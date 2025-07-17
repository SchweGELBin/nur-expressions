{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v0.1.1";
    hash = "sha256-rU9v7QermdHTRCaSEt7Cd+p0ZY2J8MDx4iD1vmExlgA=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
