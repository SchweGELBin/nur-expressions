{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "darkreader";
  version = "4.9.121";

  /*
    # The GitHub Releases are broken
    src = fetchurl {
      url = "https://github.com/darkreader/darkreader/releases/download/v${version}/darkreader-firefox.xpi";
      hash = "sha256-yD0zFlyVDOMzqTfyIzjqIhRhiI+4YMfjYi3SOmV4hDE=";
    };
  */

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4690921/darkreader-${version}.xpi";
    hash = "sha256-wOxdUE6XHfvq3cRvh5x0Cl9MfAN6Z47NMZr7eYb+Y+s=";
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
