{
  fetchFromGitHub,
  pkgs,
  rustPlatform,
}:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "MiXBot";
    tag = "v0.2.0";
    hash = "sha256-wjl/0BQQvRqPIJ5KmIJLTyhkI8tWRuOZRb835xbqrro=";
  };
in

pkgs.callPackage "${repo}/default.nix" { rustPlatform = rustPlatform; }
