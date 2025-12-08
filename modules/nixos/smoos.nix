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
    networking.firewall.allowedTCPPorts =
      lib.optionals cfg.cs.enable [ cfg.cs.settings.port ]
      ++ lib.optionals cfg.rs.enable [ cfg.rs.settings.port ];
    networking.firewall.allowedUDPPorts =
      lib.optionals cfg.cs.enable [ cfg.cs.settings.port ]
      ++ lib.optionals cfg.rs.enable [ cfg.rs.settings.port ];

    systemd.services = {
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
          WorkingDirectory = "/var/lib/smoos/cs";
        };
        wantedBy = [ "multi-user.target" ];
      };
      smoos-cs-bot = {
        enable = cfg.cs.bot.enable;
        environment =
          lib.concatMapAttrs (n: v: {
            ${"SMOOS_" + lib.toUpper n} = if lib.isBool v then lib.boolToString v else toString v;
          }) cfg.cs.bot.settings
          // {
            API_HOST = cfg.cs.settings.address;
            API_PORT = cfg.cs.settings.port;
          };
        script = lib.getExe cfg.cs.bot.package;
        serviceConfig = {
          EnvironmentFile = cfg.cs.secretFile;
          User = "smoos";
          WorkingDirectory = "/var/lib/smoos/cs";
        };
        wantedBy = [ "multi-user.target" ];
      };
      smoos-rs = {
        enable = cfg.rs.enable;
        preStart =
          lib.optionalString cfg.rs.settings.force ''
            if [ -f ./settings.json ]; then rm ./settings.json; fi
          ''
          + ''
            if [ ! -f ./settings.json ]; then
              cp ${cfg.rs.package}/settings.json .
              chmod +w ./settings.json
            fi
            sed -i -e 's/"Address":.*,/"Address": "${cfg.rs.settings.address}",/' settings.json
            sed -i -e 's/"Port":.*,/"Port": "${toString cfg.rs.settings.port}",/' settings.json
          ''
          + lib.optionalString cfg.rs.settings.jsonapi ''
            sed -i '/JsonApi/{n;s/false/true/}' ./settings.json
            sed -i -e "s/\"SECRET_TOKEN_1\"/\"$SMOOS_API_TOKEN_PUB\"/g" ./settings.json
            sed -i -e "s/\"SECRET_TOKEN_2\"/\"$SMOOS_API_TOKEN\"/g" ./settings.json
          '';
        script = "${cfg.rs.package}/bin/smo-rs";
        serviceConfig = {
          EnvironmentFile = cfg.rs.secretFile;
          User = "smoos";
          WorkingDirectory = "/var/lib/smoos/rs";
        };
        wantedBy = [ "multi-user.target" ];
      };
      smoos-rs-bot = {
        enable = cfg.rs.bot.enable;
        environment =
          lib.concatMapAttrs (n: v: {
            ${"SMOOS_" + lib.toUpper n} = if lib.isBool v then lib.boolToString v else toString v;
          }) cfg.rs.bot.settings
          // {
            API_HOST = cfg.rs.settings.address;
            API_PORT = cfg.rs.settings.port;
          };
        script = lib.getExe cfg.rs.bot.package;
        serviceConfig = {
          EnvironmentFile = cfg.rs.secretFile;
          User = "smoos";
          WorkingDirectory = "/var/lib/smoos/rs";
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
      cs = {
        enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server - C#";
        package = lib.mkPackageOption pkgs "smoos-cs" { };
        bot = {
          enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server - Bot";
          package = lib.mkPackageOption pkgs "smoos-bot" { };
          settings = lib.mkOption {
            description = "Configuration options for the Server Bot";
            type = lib.types.submodule {
              options = {
                discord_id = lib.mkOption {
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
        secretFile = lib.mkOption {
          description = ''
            File containing environment variables
            Needs `SMOOS_API_TOKEN`, `SMOOS_API_TOKEN_PUB` if `nur.smoos.cs.settings.jsonapi = true`
          '';
          example = "config.sops.secrets.smoos_env.path";
          type = lib.types.path;
        };
        settings = lib.mkOption {
          description = "Configuration options for the C# Server";
          type = lib.types.submodule {
            options = {
              address = lib.mkOption {
                default = "0.0.0.0";
                description = "Your Server Adress";
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
        rs = {
          enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server - Rust";
          package = lib.mkPackageOption pkgs "smoos-rs" { };
          bot = {
            enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server - Bot";
            package = lib.mkPackageOption pkgs "smoos-bot" { };
            settings = lib.mkOption {
              description = "Configuration options for the Server Bot";
              type = lib.types.submodule {
                options = {
                  discord_id = lib.mkOption {
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
          secretFile = lib.mkOption {
            description = ''
              File containing environment variables
              Needs `SMOOS_API_TOKEN`, `SMOOS_API_TOKEN_PUB` if `nur.smoos.cs.settings.jsonapi = true`
            '';
            example = "config.sops.secrets.smoos_env.path";
            type = lib.types.path;
          };
          settings = lib.mkOption {
            description = "Configuration options for the Rust Server";
            type = lib.types.submodule {
              options = {
                address = lib.mkOption {
                  default = "0.0.0.0";
                  description = "Your Server Adress";
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
      };
    };
  };
}
