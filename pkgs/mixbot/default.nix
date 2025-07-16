{
  fetchFromGitHub,
  pkgs,
  rustPlatform,
}:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "MiXBot";
    tag = "v0.2.1";
    hash = "sha256-bEznsFV6HALK/BWakW3+R4EKpbBGjezn/7uM7K/Uwc8=";
  };
in

pkgs.callPackage "${repo}/default.nix" { rustPlatform = rustPlatform; }
