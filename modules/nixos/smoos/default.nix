args@{ lib, ... }:
{
  imports = [
    (import ./part.nix (args // { part = "cs"; }))
    (import ./part.nix (args // { part = "rs"; }))
  ];

  options = {
    nur.smoos.enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server";
  };
}
