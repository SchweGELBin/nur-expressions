{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "Bible4TUI";
    tag = "v0.5.0";
    hash = "sha256-qfrPwzr9Q4fuhlJSWAmL9F97A4uXUd5QZhvPvBriiFI=";
  };
in

pkgs.callPackage src { }
