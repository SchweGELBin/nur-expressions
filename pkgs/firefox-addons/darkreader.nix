{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "darkreader";
  version = "4.9.135";

  /*
    # The GitHub Releases are broken
    src = fetchurl {
      url = "https://github.com/darkreader/darkreader/releases/download/v${version}/darkreader-firefox.xpi";
      hash = "sha256-EVVUjCSuA+8HxMNcSt2hncdZKYKjf6Hj5txh23McNQM=";
    };
  */
  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/5216111/darkreader-${version}.xpi";
    hash = "sha256-v+1FkdbMaYV/XtM6LTy/vFgR1bksQyPQc10vF1fi3OQ=";
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
