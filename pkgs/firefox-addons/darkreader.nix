{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "darkreader";
  version = "4.9.134";

  /*
    # The GitHub Releases are broken
    src = fetchurl {
      url = "https://github.com/darkreader/darkreader/releases/download/v${version}/darkreader-firefox.xpi";
      hash = "sha256-kRJGZzMHot4AK22Ea/T48kW39ZSEkdOHgoMlC5twuiY=";
    };
  */

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/5175215/darkreader-${version}.xpi";
    hash = "sha256-cAYzOVqi9jmhvtQlPicwnrZ280bVmbCuK3oEUyMuCuw=";
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
