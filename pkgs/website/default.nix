{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.1.2";
    hash = "sha256-ITI7EDD0ABjmvYWE2d7IBNvjp8Ujma8VjX/WO269jwk=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
