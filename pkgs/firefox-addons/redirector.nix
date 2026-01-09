{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "redirector";
  version = "3.5.3";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/3535009/redirector-${version}.xpi";
    hash = "sha256-7dvT1ZROdI0L1uy22enPDgwC3O1vQtshqrZBkOccD3E=";
  };

  addonId = "redirector@einaregilsson.com";

  meta = {
    description = "Redirect urls based on regex patterns";
    homepage = "http://einaregilsson.com/redirector/";
    changelog = "https://addons.mozilla.org/en-US/firefox/addon/redirector/versions/";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.SchweGELBin ];
  };
}
