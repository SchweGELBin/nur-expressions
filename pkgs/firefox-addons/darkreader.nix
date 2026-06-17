{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "darkreader";
  version = "4.9.127";

  /*
    # The GitHub Releases are broken
    src = fetchurl {
      url = "https://github.com/darkreader/darkreader/releases/download/v${version}/darkreader-firefox.xpi";
      hash = "sha256-7uYIZLnGkgNXM5qI+zXgwkWUWMg1Ac5p2qxxZoFYOro=";
    };
  */

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4837294/darkreader-${version}.xpi";
    hash = "sha256-JfBrELQycCZq9jyNJeAez15Je9LVQRJD7m0Zs4aSlq0=";
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
