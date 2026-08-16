{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "skip-redirect";
  version = "3.0.1";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4951882/skip_redirect-${version}.xpi";
    hash = "sha256-6YFYCyPB35MW8E/baSHmfdyAG4y//Ib+5jZDMWdKQlM=";
  };

  addonId = "skipredirect@sblask";

  meta = {
    description = "Tries to extract the final url from the intermediary url and goes there straight away if successful";
    homepage = "https://github.com/sblask-webextensions/webextension-skip-redirect";
    changelog = "https://addons.mozilla.org/en-US/firefox/addon/skip-redirect/versions/";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.SchweGELBin ];
  };
}
