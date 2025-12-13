{
  config,
  lib,
  pkgs,
  part ? "part",
}:
let
  cfg = config.nur.smoos.${part};
  name = "smoos-${part}";
in
{
  config = lib.mkIf (config.nur.smoos.enable && cfg.enable) {
    networking.firewall =
      let
        ports = [
          cfg.settings.port
        ]
        ++ lib.optional (
          cfg.settings.jsonapi-enable && cfg.settings.jsonapi-port != null
        ) cfg.settings.jsonapi-port;
      in
      {
        allowedTCPPorts = ports;
        allowedUDPPorts = ports;
      };

    systemd.services = {
      ${name} = {
        enable = cfg.enable;
        preStart =
          let
            defaultSettings = import "${cfg.package}/settings.nix";
            settings =
              defaultSettings
              // {
                Address = cfg.settings.address;
                Port = cfg.settings.port;
                JsonApi = defaultSettings.JsonApi // {
                  Enabled = cfg.settings.jsonapi-enable;
                };
              }
              // lib.optionalAttrs (cfg.settings.jsonapi-port != null) {
                JsonApi = defaultSettings.JsonApi // {
                  Enabled = cfg.settings.jsonapi-enable;
                  Port = cfg.settings.jsonapi-port;
                };
              };
          in
          lib.optionalString cfg.settings.force ''
            if [ -f ./settings.json ]; then rm ./settings.json; fi
          ''
          + ''
            if [ ! -f ./settings.json ]; then
              echo '${lib.strings.toJSON settings}' | ${lib.getExe pkgs.jq} > ./settings.json
              chmod +w ./settings.json
            fi
          ''
          + lib.optionalString cfg.settings.jsonapi-enable ''
            sed -i "s/\"SECRET_TOKEN_1\"/\"$SMOOS_API_TOKEN_PUB\"/g" ./settings.json
            sed -ie "s/\"SECRET_TOKEN_2\"/\"$SMOOS_API_TOKEN\"/g" ./settings.json
          '';
        script = lib.getExe cfg.package;
        serviceConfig = {
          EnvironmentFile = cfg.secretFile;
          User = name;
          WorkingDirectory = "/var/lib/${name}";
        };
        wantedBy = [ "multi-user.target" ];
      };
      "${name}-bot" = {
        enable = cfg.enable && cfg.bot.enable;
        environment =
          lib.concatMapAttrs (n: v: {
            ${"SMOOS_" + lib.toUpper n} = if lib.isBool v then lib.boolToString v else toString v;
          }) cfg.bot.settings
          // {
            SMOOS_API_HOST = cfg.settings.address;
            SMOOS_API_PORT =
              if (cfg.settings.jsonapi-port != null) then
                toString cfg.settings.jsonapi-port
              else
                toString cfg.settings.port;
          };
        script = lib.getExe cfg.bot.package;
        serviceConfig = {
          EnvironmentFile = cfg.secretFile;
          User = name;
          WorkingDirectory = "/var/lib/${name}";
        };
        wantedBy = [ "multi-user.target" ];
        wants = [ "${name}.service" ];
      };
    };

    users.users.${name} = {
      createHome = true;
      group = "systemd";
      home = "/var/lib/${name}";
      isSystemUser = true;
    };
  };

  options.nur.smoos.${part} = {
    enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server - ${part}";
    package = lib.mkPackageOption pkgs name { };
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
        Needs `SMOOS_API_TOKEN`, `SMOOS_API_TOKEN_PUB` if `nur.smoos.${part}.settings.jsonapi-enable = true`
      '';
      example = "config.sops.secrets.smoos_env.path";
      type = lib.types.path;
    };
    settings = lib.mkOption {
      description = "Configuration options for the ${part} Server";
      type = lib.types.submodule {
        options = {
          address = lib.mkOption {
            default = "0.0.0.0";
            description = "Your Server Adress";
            type = lib.types.str;
          };
          force = lib.mkEnableOption "Replace existing settings";
          jsonapi-enable = lib.mkOption {
            default = cfg.bot.enable;
            description = "Enable the JsonApi";
            example = true;
            type = lib.types.bool;
          };
          jsonapi-port = lib.mkOption {
            default = null;
            description = "Your JsonApi Port";
            example = 1128;
            type = with lib.types; nullOr port;
          };
          port = lib.mkOption {
            default = 1027;
            description = "Your Server Port";
            example = 1028;
            type = lib.types.port;
          };
        };
      };
    };
  };
}
