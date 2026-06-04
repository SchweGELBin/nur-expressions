{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "stylus";
  version = "2.3.30";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4827922/styl_us-${version}.xpi";
    hash = "sha256-99/Z/CRcfEUtZl37FkBYXVAVsI+u1BFPCyjvkLZXXb0=";
  };

  addonId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";

  meta = {
    description = "Userstyles Manager";
    homepage = "https://add0n.com/stylus.html";
    changelog = "https://addons.mozilla.org/en-US/firefox/addon/styl-us/versions/";
    license = lib.licenses.gpl3Plus;
    maintainers = [ lib.maintainers.SchweGELBin ];
  };
}
