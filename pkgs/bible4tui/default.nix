{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "Bible4TUI";
    tag = "v0.2.0";
    hash = "sha256-Z2xf1BbJsHoxrnUJMghzQG8voBgDLwDL9p0AWOAnaSM=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
