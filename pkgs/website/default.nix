{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.0.0";
    hash = "sha256-k2+vyPDNZACAzmzDE52I5T4trE5nsoN+TEHLIGjKylY=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
