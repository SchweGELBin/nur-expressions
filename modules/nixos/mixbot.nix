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
        EnvironmentFile = cfg.secretFile;
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
      secretFile = lib.mkOption {
        description = ''
          File containing environment variables
          Needs `MIXBOT_DISCORD_TOKEN`
        '';
        example = "config.sops.secrets.smoos_env.path";
        type = lib.types.path;
      };
      settings = lib.mkOption {
        type = lib.types.submodule {
          options = {
            MIXBOT_DISCORD_ID = lib.mkOption {
              description = "Your Discord User ID";
              example = "123456789012345678";
              type = lib.types.str;
            };
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
