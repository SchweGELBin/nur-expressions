{ fetchgit, pkgs }:
let
  pin = import ./pin.nix;
  src = fetchgit {
    url = "https://github.com/SchweGELBin/smoos";
    fetchSubmodules = true;
    tag = pin.version;
    hash = pin.subHash;
  };
in

pkgs.callPackage "${src}/smoos-rs" { }
