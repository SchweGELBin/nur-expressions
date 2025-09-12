{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.4.2";
    hash = "sha256-hbQtKuE7H1DW+TlO5k+d3wDDzhoEIWIalGo1qqwH7HM=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
