{ lib, ... }:
{
  imports = [
    (import ./part.nix { part = "cs"; })
    (import ./part.nix { part = "rs"; })
  ];

  options = {
    nur.smoos.enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server";
  };
}
