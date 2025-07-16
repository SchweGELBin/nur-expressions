{
  fetchFromGitHub,
  pkgs,
  rustPlatform,
}:
let
  pin = import ./pin.nix;
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "smoos";
    tag = pin.version;
    hash = pin.hash;
  };
in

pkgs.callPackage "${repo}/default.nix" { rustPlatform = rustPlatform; }
