{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.2";
    hash = "sha256-RsuuQLTlyQXZ/Mh1vBt9Pg9tmGuLLQwi6dn57Dde+vk=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
