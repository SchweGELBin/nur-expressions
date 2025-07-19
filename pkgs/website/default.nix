{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v0.1.2";
    hash = "sha256-YEQmLGLTcjTafpL2qyked9IME8nqyv05zrDZRjDjHJc=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
