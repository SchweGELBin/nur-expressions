{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.13";
    hash = "sha256-tktgRAwlMj1+dBvraBAV4UqSe8RGVv+/GRdFXuMHie0=";
  };
in

pkgs.callPackage src { }
