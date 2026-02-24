{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "darkreader";
  version = "4.9.121";

  src = fetchurl {
    url = "https://github.com/darkreader/darkreader/releases/download/v${version}/darkreader-firefox.xpi";
    hash = "sha256-yD0zFlyVDOMzqTfyIzjqIhRhiI+4YMfjYi3SOmV4hDE=";
  };

  addonId = "addon@darkreader.org";

  meta = {
    description = "Analyzes web pages and aims to reduce eyestrain while browsing the web";
    homepage = "https://darkreader.org/";
    changelog = "https://github.com/darkreader/darkreader/blob/${version}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.SchweGELBin ];
  };
}
