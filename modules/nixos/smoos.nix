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
    networking.firewall.allowedTCPPorts = [ ] ++ lib.optionals cfg.cs.enable [ 1027 ];

    systemd.services = {
      smoos-bot = {
        enable = cfg.bot.enable;
        script = lib.getExe cfg.bot.package;
        serviceConfig = {
          EnvironmentFile = cfg.bot.environmentFile;
          User = "smoos";
          WorkingDirectory = "/var/lib/smoos";
        };
        wantedBy = [ "multi-user.target" ];
      };
      smoos-cs = {
        enable = cfg.cs.enable;
        preStart = ''
          if [ ! -f ./settings.json ]; then
            cp ${cfg.cs.package}/settings.json .
            sed -i '/JsonApi/{n;s/false/true/}' ./settings.json
            sed -i -e "s/\"SECRET_TOKEN_1\"/\"$SMOOS_API_TOKEN_PUB\"/g" ./settings.json
            sed -i -e "s/\"SECRET_TOKEN_2\"/\"$SMOOS_API_TOKEN\"/g" ./settings.json
          fi
        '';
        script = "${cfg.cs.package}/bin/Server";
        serviceConfig = {
          EnvironmentFile = cfg.cs.environmentFile;
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
        environmentFile = lib.mkOption {
          type = lib.types.path;
          description = ''
            File containing environment variables
            Needs `SMOOS_API_TOKEN`, `SMOOS_DISCORD_ID`, `SMOOS_DISCORD_TOKEN`
          '';
        };
        package = lib.mkPackageOption pkgs "smoos-bot" { };
      };
      cs = {
        enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server - C#";
        environmentFile = lib.mkOption {
          type = lib.types.path;
          description = ''
            File containing environment variables
            Needs `SMOOS_API_TOKEN`, `SMOOS_API_TOKEN_PUB`
          '';
        };
        package = lib.mkPackageOption pkgs "smoos-cs" { };
      };
      rs = {
        enable = lib.mkEnableOption "Enable Super Mario Odyssey: Online Server - Rust";
      };
    };
  };
}
