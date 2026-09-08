{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "skip-redirect";
  version = "3.0.2";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4968151/skip_redirect-${version}.xpi";
    hash = "sha256-HtnEyhX87Slj3AAdlcR0Xu2aHFu5121woxQNvVcVudc=";
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
