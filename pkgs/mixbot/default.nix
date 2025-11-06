{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "MiXBot";
    tag = "v0.3.1";
    hash = "sha256-Fyz8E6atDwDVcH38GvZ4lelFyKHH1oG78rndkQsYr78=";
  };
in

pkgs.callPackage src { }
