{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "firefox-color";
  version = "2.1.7";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/3643624/firefox_color-${version}.xpi";
    hash = "sha256-t/sHtniPcjPdYiPngOGJtMe5VsJcQEk8KNcCBJMkkpI=";
  };

  addonId = "FirefoxColor@mozilla.com";

  meta = {
    description = "Build, save and share beautiful Firefox themes";
    homepage = "https://color.firefox.com/";
    changelog = "https://addons.mozilla.org/en-US/firefox/addon/firefox-color/versions/";
    license = lib.licenses.mpl20;
    maintainers = [ lib.maintainers.SchweGELBin ];
  };
}
