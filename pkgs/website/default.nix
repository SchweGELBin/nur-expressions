{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.8";
    hash = "sha256-tdrgCkLyovJnby0AvCgpdiuSmIxipwRgONtKSEwnkn4=";
  };
in

pkgs.callPackage src { }
