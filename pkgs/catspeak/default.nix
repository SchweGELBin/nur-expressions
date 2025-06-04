{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "catspeak";
    tag = "v1.2.3";
    hash = "sha256-e2fYBqgZjKBw9KhB0Aydtrl77zT85rLG/P6morcuFpY=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
