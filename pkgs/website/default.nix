{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.5.0";
    hash = "sha256-D+835Aad7S+ardjrCQZ9BXe9L2OGDRsrxj5Y38a4+nk=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
