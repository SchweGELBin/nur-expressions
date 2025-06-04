{ fetchgit, pkgs }:
let
  pin = import ./pin.nix;
  repo = fetchgit {
    url = "https://github.com/SchweGELBin/smoos";
    fetchSubmodules = true;
    tag = pin.version;
    hash = pin.subHash;
  };
in

pkgs.callPackage "${repo}/smoos-rs/default.nix" { };
