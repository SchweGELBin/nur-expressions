{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "website";
    tag = "v1.6.7";
    hash = "sha256-Y1QxB5VF7nBdu+pYhsaGglu0fY6AJcGXnTkNBHuqw90=";
  };
in

pkgs.callPackage src { }
