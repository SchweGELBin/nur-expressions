{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.5.2";
    hash = "sha256-nIOgOGDCVLlSODAXI5qtvi9IUkvO3WUqLmLWenm5weU=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
