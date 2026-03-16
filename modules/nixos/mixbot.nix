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
      environment = lib.concatMapAttrs (n: v: {
        ${"MIXBOT_" + lib.toUpper n} = if lib.isBool v then lib.boolToString v else toString v;
      }) cfg.settings;
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
          Needs `MIXBOT_DISCORD_TOKEN` to enable the Discord Bot
        '';
        example = "config.sops.secrets.mixbot_env.path";
        type = lib.types.path;
      };
      settings = lib.mkOption {
        description = "Configuration options for the Minecraft Bot";
        type = lib.types.submodule {
          options = {
            accounts = lib.mkOption {
              default = "MiXBot,false";
              description = "Your Bot's Name + Auth Mode";
              example = "your@domain.tld,true";
              type = lib.types.str;
            };
            host = lib.mkOption {
              default = "localhost";
              description = "Your Server IP";
              example = "your.domain.tld";
              type = lib.types.str;
            };
            owner = lib.mkOption {
              default = "";
              description = "Your Bot's Owner Name";
              example = "SchweGELBin";
              type = lib.types.str;
            };
            prefix = lib.mkOption {
              default = "!";
              description = "Your Bot's Command Prefix";
              example = ".";
              type = lib.types.str;
            };
            discord_id = lib.mkOption {
              default = "";
              description = "Your Discord User ID";
              example = "123456789012345678";
              type = lib.types.str;
            };
            discord_prefix = lib.mkOption {
              default = "!";
              description = "Your Discord Bot Command Prefix";
              example = ".";
              type = lib.types.str;
            };
          };
        };
      };
    };
  };
}
