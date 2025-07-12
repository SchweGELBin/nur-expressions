{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nur.mixbot;
in
{
  config = lib.mkIf cfg.enable { };

  options = {
    nur.mixbot = {
      enable = lib.mkEnableOption "Enable Minecraft MiXBot";
      package = lib.mkPackageOption pkgs "mixbot" { };
      settings = lib.mkOption {
        type = lib.types.submodule {
          options = {
            MIXBOT_HOST = lib.mkOption {
              default = "localhost";
              description = "Your Server IP";
              example = "example.com";
              type = lib.types.str;
            };
            MIXBOT_PORT = lib.mkOption {
              default = 25565;
              description = "Your Server Port";
              example = 25000;
              type = lib.types.int;
            };
            MIXBOT_ONLINE = lib.mkEnableOption "Server in Online Mode";
            MIXBOT_USERNAME = lib.mkOption {
              description = "Your Bot's Username";
              example = "Bot";
              type = lib.types.str;
            };
            MIXBOT_VIEWER_PORT = lib.mkOption {
              default = 3007;
              description = "Your Bot's Viewer Port";
              example = 3008;
              type = lib.types.int;
            };
          };
        };
      };
    };
  };
}
