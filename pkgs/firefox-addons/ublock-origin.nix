{
  buildXpi,
  fetchurl,
  lib,
}:

buildXpi rec {
  pname = "ublock-origin";
  version = "1.75.1b1";

  src = fetchurl {
    url = "https://github.com/gorhill/uBlock/releases/download/${version}/uBlock0_${version}.firefox.signed.xpi";
    hash = "sha256-VrugiSh7am9aLZn1Q1NeuMLEpRjdgseWKRjeQyLiBY8=";
  };

  addonId = "uBlock0@raymondhill.net";

  meta = {
    description = "An efficient wide-spectrum content blocker. Fast and lean.";
    homepage = "https://github.com/gorhill/uBlock";
    changelog = "https://github.com/gorhill/uBlock/blob/${version}/CHANGELOG.md";
    license = lib.licenses.gpl3Plus;
    maintainers = [ lib.maintainers.SchweGELBin ];
  };
}
