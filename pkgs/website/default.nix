{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.4";
    hash = "sha256-v+J2eQgZxk7o3YSvaXWno920jYTO/PaJNdmEFxD2c+Q=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
