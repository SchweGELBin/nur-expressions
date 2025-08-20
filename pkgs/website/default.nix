{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.3.0";
    hash = "sha256-IQezUomVKot2wV8ws8ZVn9KJE4MkLa1voiQiWmRCJPc=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
