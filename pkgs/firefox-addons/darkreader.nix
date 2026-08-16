{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "darkreader";
  version = "4.9.129";

  /*
    # The GitHub Releases are broken
    src = fetchurl {
      url = "https://github.com/darkreader/darkreader/releases/download/v${version}/darkreader-firefox.xpi";
      hash = "sha256-F1RYR9T2Jwc9sOSGo3YmiJMT5ygWyyv9BXaUMNqppjc=";
    };
  */

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4899461/darkreader-${version}.xpi";
    hash = "sha256-9PBH/gjkILbSlhdzjqAKe3hIkrImK35vON0JuO6VikQ=";
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
