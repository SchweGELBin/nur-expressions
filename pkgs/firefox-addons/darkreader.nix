{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "darkreader";
  version = "4.9.130";

  /*
    # The GitHub Releases are broken
    src = fetchurl {
      url = "https://github.com/darkreader/darkreader/releases/download/v${version}/darkreader-firefox.xpi";
      hash = "sha256-jyACYdxB6q0nuOuuZuHfrKerxilgLkKGEj4apcalyyY=";
    };
  */

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4998573/darkreader-${version}.xpi";
    hash = "sha256-B11UVzFq8h1io5opCzH79x9RTfyMP2qHN2/VD1TvTJw=";
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
