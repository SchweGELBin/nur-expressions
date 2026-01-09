{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nur.firefox;
in
{
  config = lib.mkIf cfg.enable {
    programs.firefox.profiles.${cfg.profile} = {
      extensions.settings = lib.optionalAttrs cfg.extensions.defaultSettings.enable {
        "FirefoxColor@mozilla.com".settings.firstRunDone = true;
        "skipredirect@sblask".settings.blacklist = [
          "/abp"
          "/account"
          "/adfs"
          "/auth"
          "/cookie"
          "/download"
          "/login"
          "/logoff"
          "/logon"
          "/logout"
          "/oauth"
          "/openid"
          "/pay"
          "/preference"
          "/profile"
          "/register"
          "/saml"
          "/signin"
          "/signoff"
          "/signon"
          "/signout"
          "/signup"
          "/sso"
          "/subscribe"
          "/unauthenticated"
          "/verification"
          "https://external-content.duckduckgo.com"
          "https://web.archive.org/web"
        ];
      };
      settings =
        (
          if cfg.settings.harden.enable then
            import "${pkgs.callPackage ../../pkgs/usernix { }}/${cfg.settings.harden.mode}.nix"
          else
            { }
        )
        // lib.optionalAttrs cfg.settings.clear.enable {
          "privacy.clearHistory.browsingHistoryAndDownloads" = true;
          "privacy.clearHistory.cache" = true;
          "privacy.clearHistory.cookiesAndStorage" = true;
          "privacy.clearHistory.formdata" = true;
          "privacy.clearHistory.historyFormDataAndDownloads" = true;
          "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
          "privacy.clearOnShutdown_v2.cache" = true;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
          "privacy.clearOnShutdown_v2.downloads" = true;
          "privacy.clearOnShutdown_v2.formdata" = true;
          "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
          "privacy.clearSiteData.browsingHistoryAndDownloads" = true;
          "privacy.clearSiteData.cache" = true;
          "privacy.clearSiteData.cookiesAndStorage" = true;
          "privacy.clearSiteData.formdata" = true;
          "privacy.clearSiteData.historyFormDataAndDownloads" = true;
        };
    };
  };

  options = {
    nur.firefox = {
      enable = lib.mkEnableOption "Enable Firefox configuration";
      extensions.defaultSettings.enable = lib.mkEnableOption "Enable provided extension settings";
      profile = lib.mkOption {
        description = "Your profile name";
        type = lib.types.str;
      };
      settings = {
        clear.enable = lib.mkEnableOption "Enable clear data";
        harden = {
          enable = lib.mkEnableOption "Enable hardening";
          mode = lib.mkOption {
            default = "arkenfox";
            description = "Hardening config";
            type = lib.types.enum [
              "arkenfox"
              "betterfox"
              "fastfox"
              "peskyfox"
              "securefox"
              "smoothfox"
            ];
          };
        };
      };
    };
  };
}
