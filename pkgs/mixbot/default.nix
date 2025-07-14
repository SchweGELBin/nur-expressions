{
  fetchFromGitHub,
  pkgs,
  rustPlatform,
}:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "MC-MiXBot";
    tag = "v0.0.1";
    hash = "sha256-unPCMk4FsTAnHUq1tfh6hcNdmJiKIcJW0aGC2xJjSVQ=";
  };
in

pkgs.callPackage "${repo}/default.nix" { rustPlatform = rustPlatform; }
