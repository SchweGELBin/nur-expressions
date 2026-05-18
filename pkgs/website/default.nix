{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.12";
    hash = "sha256-+R6f5i8EsuKbqj7Eu0JGXmsf43HSM68PyhIThoembYQ=";
  };
in

pkgs.callPackage src { }
