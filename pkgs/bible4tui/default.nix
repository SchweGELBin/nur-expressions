{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "Bible4TUI";
    tag = "v0.4.0";
    hash = "sha256-KGkp66AkEFL+c1LN48OkMVPAYHYbPH0jrmvJoqSH6z0=";
  };
in

pkgs.callPackage src { }
