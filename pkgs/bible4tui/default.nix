{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "Bible4TUI";
    tag = "v0.3.0";
    hash = "sha256-X5j8adkhLErGTLMCnGqKzWaUJA6UlTSUTAwSoYwRSE0=";
  };
in

pkgs.callPackage src { }
