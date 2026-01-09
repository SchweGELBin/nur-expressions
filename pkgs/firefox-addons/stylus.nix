{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "stylus";
  version = "2.3.18";

  src = fetchurl {
    url = "https://github.com/openstyles/stylus/releases/download/v${version}/stylus-firefox-mv2-${version}.xpi";
    hash = "sha256-3PHWUEZS7jTkCZHfAwgXgl6pgNltWFlnYQMxe1aV/bs=";
  };

  addonId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";

  meta = {
    description = "Userstyles Manager";
    homepage = "https://add0n.com/stylus.html";
    changelog = "https://github.com/openstyles/stylus/releases/tag/v${version}";
    license = lib.licenses.gpl3Plus;
    maintainers = [ lib.maintainers.SchweGELBin ];
  };
}
