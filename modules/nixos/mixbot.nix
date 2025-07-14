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
  config = lib.mkIf cfg.enable {
    systemd.services.mixbot = {
      enable = cfg.enable;
      environment = lib.mapAttrs (
        _: v: if lib.isBool v then lib.boolToString v else toString v
      ) cfg.settings;
      script = lib.getExe cfg.package;
      serviceConfig = {
        User = "mixbot";
        WorkingDirectory = "/var/lib/mixbot";
      };
      wantedBy = [ "multi-user.target" ];
    };
    users.users.mixbot = {
      createHome = true;
      group = "systemd";
      home = "/var/lib/mixbot";
      isSystemUser = true;
    };
  };

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
            MIXBOT_NAME = lib.mkOption {
              default = "MiXBot";
              description = "Your Bot's Name";
              example = "Bot";
              type = lib.types.str;
            };
            MIXBOT_ONLINE = lib.mkEnableOption "Authenticate with Microsoft";
          };
        };
      };
    };
  };
}
