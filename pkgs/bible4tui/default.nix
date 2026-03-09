{ fetchFromGitHub, pkgs }:
let
  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "Bible4TUI";
    tag = "v0.5.1";
    hash = "sha256-oVcfkoiXbnqEh1SigqoV4s3hox4ZAEt6f+bBZivH6TQ=";
  };
in

pkgs.callPackage src { }
