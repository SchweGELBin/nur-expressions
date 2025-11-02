{ config, lib, ... }:
let
  cfg = config.nur.overlay;
in
{
  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ (import ../../overlay.nix) ];
  };

  options = {
    nur.overlay.enable = lib.mkEnableOption "Enable nixpkgs overlay";
  };
}
