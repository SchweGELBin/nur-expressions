{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.10";
    hash = "sha256-dQyOXjMOcWOvUgGY5akUCu5d+UVTX5rvAtk3hScyUcE=";
  };
in

pkgs.callPackage src { }
