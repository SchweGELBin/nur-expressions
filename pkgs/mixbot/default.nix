{
  fetchFromGitHub,
  pkgs,
  rustPlatform,
}:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "MC-MiXBot";
    tag = "v0.1.0";
    hash = "sha256-VikM4X4mq5lH2MWmKIq0wGkbJxfucoAk2nwh8ICFx9w=";
  };
in

pkgs.callPackage "${repo}/default.nix" { rustPlatform = rustPlatform; }
