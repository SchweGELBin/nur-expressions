{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "skip-redirect";
  version = "2.3.6";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/3920533/skip_redirect-${version}.xpi";
    hash = "sha256-2+iVAkXB9HXFwcbaq4nHm4O6RoBiHJHoDxW+ewm2GK4=";
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
