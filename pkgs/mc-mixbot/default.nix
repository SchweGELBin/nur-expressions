{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "MC-MiXBot";
    tag = "v0.0.0";
    hash = "sha256-C79pveAOc0uL/WmLg5D2u8k8da1uj/lR78kmpJgUOnU=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
