{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nur.smoos;
in
{
  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ ] ++ lib.optionals cfg.cs.enable [ cfg.cs.settings.port ];

    systemd.services = {
      smoos-bot = {
        enable = cfg.bot.enable;
        environment = lib.mapAttrs (
          _: v: if lib.isBool v then lib.boolToString v else toString v
        ) cfg.bot.settings;
        script = lib.getExe cfg.bot.package;
        serviceConfig = {
          EnvironmentFile = cfg.bot.secretFile;
          User = "smoos";
          WorkingDirectory = "/var/lib/smoos";
        };
        wantedBy = [ "multi-user.target" ];
      };
      smoos-cs = {
        enable = cfg.cs.enable;
        preStart =
          lib.optionalString cfg.cs.settings.force ''
            if [ -f ./settings.json ]; then rm ./settings.json; fi
          ''
          + ''
            if [ ! -f ./settings.json ]; then
              cp ${cfg.cs.package}/settings.json .
              chmod +w ./settings.json
            fi
            sed -i -e 's/"Address":.*,/"Address": "${cfg.cs.settings.address}",/' settings.json
            sed -i -e 's/"Port":.*,/"Port": "${toString cfg.cs.settings.port}",/' settings.json
          ''
          + lib.optionalString cfg.cs.settings.jsonapi ''
            sed -i '/JsonApi/{n;s/false/true/}' ./settings.json
            sed -i -e "s/\"SECRET_TOKEN_1\"/\"$SMOOS_API_TOKEN_PUB\"/g" ./settings.json
            sed -i -e "s/\"SECRET_TOKEN_2\"/\"$SMOOS_API_TOKEN\"/g" ./settings.json
          '';
        script = "${cfg.cs.package}/bin/Server";
        serviceConfig = {
          EnvironmentFile = cfg.cs.secretFile;
          User = "smoos";
          WorkingDirectory = "/var/lib/smoos";
        };
        wantedBy = [ "multi-user.target" ];
      };
    };

    users.users.smoos = {
      createHome = true;
      group = "systemd";
      home = "/var/lib/smoos";
      isSystemUser = true;
    };
  };

  options = {
    nur.smoos = {
      enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server";
      bot = {
        enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server - Bot";
        package = lib.mkPackageOption pkgs "smoos-bot" { };
        secretFile = lib.mkOption {
          description = ''
            File containing environment variables
            Needs `SMOOS_API_TOKEN`, `SMOOS_DISCORD_TOKEN`
          '';
          example = "config.sops.secrets.smoos_env.path";
          type = lib.types.path;
        };
        settings = lib.mkOption {
          type = lib.types.submodule {
            options = {
              SMOOS_API_HOST = lib.mkOption {
                default = "localhost";
                description = "Your Server IP";
                example = "example.com";
                type = lib.types.str;
              };
              SMOOS_API_PORT = lib.mkOption {
                default = 1027;
                description = "Your Server Port";
                example = 1028;
                type = lib.types.int;
              };
              SMOOS_DISCORD_ID = lib.mkOption {
                description = "Your Discord User ID";
                example = "123456789012345678";
                type = lib.types.str;
              };
              SMOOS_DISCORD_PREFIX = lib.mkOption {
                default = "!";
                description = "Your Discord Bot Command Prefix";
                example = ".";
                type = lib.types.str;
              };
            };
          };
        };
      };
      cs = {
        enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server - C#";
        package = lib.mkPackageOption pkgs "smoos-cs" { };
        secretFile = lib.mkOption {
          description = ''
            File containing environment variables
            Needs `SMOOS_API_TOKEN`, `SMOOS_API_TOKEN_PUB` if `nur.smoos.cs.settings.jsonapi = true`
          '';
          example = "config.sops.secrets.smoos_env.path";
          type = lib.types.path;
        };
        settings = lib.mkOption {
          type = lib.types.submodule {
            options = {
              address = lib.mkOption {
                default = "0.0.0.0";
                description = "Your Server Adress";
                example = "example.com";
                type = lib.types.str;
              };
              force = lib.mkEnableOption "Replace existing settings";
              jsonapi = lib.mkEnableOption "Enable the JsonApi, necessary if you want to use smoos-bot";
              port = lib.mkOption {
                default = 1027;
                description = "Your Server Port";
                example = 1028;
                type = lib.types.int;
              };
            };
          };
        };
      };
      rs.enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server - Rust";
    };
  };
}
