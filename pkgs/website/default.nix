{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.9";
    hash = "sha256-w1oNHrXaDLPSxqKsFSpvLbM04Lku/NZr/bk0cs71vCQ=";
  };
in

pkgs.callPackage src { }
