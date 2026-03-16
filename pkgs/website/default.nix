{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.11";
    hash = "sha256-VGjGrIfAn40jfUxjUqAEJvwsVad8Cf2okXPAkQroF2g=";
  };
in

pkgs.callPackage src { }
