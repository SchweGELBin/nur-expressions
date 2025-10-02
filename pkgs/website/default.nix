{ fetchFromGitHub, pkgs }:
let
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.0";
    hash = "sha256-kXlqNfxAHu3s8LJZI0A2oQdh/yJi9OGmWSpX16fVKJI=";
  };
in

pkgs.callPackage "${repo}/default.nix" { }
