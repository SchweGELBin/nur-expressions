{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "MiXBot";
    tag = "v0.3.0";
    hash = "sha256-fZHSyz4r9C1ohXNdmC5aIABrl9y7VnSjtc0PZF4NUmc=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
