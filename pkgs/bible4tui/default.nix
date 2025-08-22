{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "Bible4TUI";
    tag = "v0.1.0";
    hash = "sha256-867qzA9rk0u9hM8zqPmPcf1/WsL8JRxV1iXMPv0eG8I=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
