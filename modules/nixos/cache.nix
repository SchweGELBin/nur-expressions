{ config, lib, ... }:
let
  cfg = config.nur.cache;
in
{
  config = lib.mkIf cfg.enable {
    nix.settings = {
      substituters = "https://schwegelbin.cachix.org";
      trusted-public-keys = "schwegelbin.cachix.org-1:Ckh//WCg8vz3W1AzjD/QdYZ4VHA7ZU/q7nXb98IZ+TQ=";
    };
  };

  options = {
    nur.cache.enable = lib.mkEnableOption "Enable Cachix Cache";
  };
}
