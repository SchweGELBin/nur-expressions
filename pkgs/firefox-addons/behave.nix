{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "behave";
  version = "0.9.7.1";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/3606644/behave-${version}.xpi";
    hash = "sha256-mDtD2ia0nfQhGGxdVQsnqtNuOHYQicAy6xhEHT/9Idk=";
  };

  addonId = "{17c7f098-dbb8-4f15-ad39-8b578da80f7e}";

  meta = {
    description = "A monitoring browser extension for pages acting as \"bad boi\"";
    homepage = "https://github.com/mindedsecurity/behave";
    changelog = "https://addons.mozilla.org/en-US/firefox/addon/behave/versions/";
    license = lib.licenses.gpl3Plus;
    maintainers = [ lib.maintainers.SchweGELBin ];
  };
}
