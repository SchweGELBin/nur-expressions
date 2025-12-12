{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (import ./part.nix {
      inherit config;
      inherit lib;
      inherit pkgs;
      part = "cs";
    })
    (import ./part.nix {
      inherit config;
      inherit lib;
      inherit pkgs;
      part = "rs";
    })
  ];

  options = {
    nur.smoos.enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server";
  };
}
