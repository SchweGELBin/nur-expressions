let
  validModes = [
    "arkenfox"
    "betterfox"
    "fastfox"
    "peskyfox"
    "securefox"
    "smoothfox"
  ];
in
{
  fetchurl,
  lib,
  stdenvNoCC,
  modes ? validModes,
}:
let
  arkenfox = fetchurl {
    url = "https://raw.githubusercontent.com/arkenfox/user.js/7602fda9fc4058f53abe5e528942a2afe0bccf74/user.js";
    hash = "sha256-ugm1BbuvH9L0qHd6WCIiX0L6vYgt1bus7Lmu791jpG0=";
  };
  betterfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/0a3fc9408bfb68e6adc785c31f16d9e32c846651/user.js";
    hash = "sha256-ri/6ZTL9mSbaSwl4jgdcB+GPnoX9zVMLkXAmkaOSLZM=";
  };
  fastfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/0a3fc9408bfb68e6adc785c31f16d9e32c846651/Fastfox.js";
    hash = "sha256-mjU0xxZmWhW8ICVn5xwg7/UFTuJXx4YhO2TSG7/m1Ek=";
  };
  peskyfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/0a3fc9408bfb68e6adc785c31f16d9e32c846651/Peskyfox.js";
    hash = "sha256-FwrcnlDHyHPrJGEH37qz3G9bHNpcX0wfI6bigG6uUPA=";
  };
  securefox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/0a3fc9408bfb68e6adc785c31f16d9e32c846651/Securefox.js";
    hash = "sha256-mvr5U/PY3SzfFZuWiJAd29m+QdnBoCYuWJfzPCZXwt4=";
  };
  smoothfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/0a3fc9408bfb68e6adc785c31f16d9e32c846651/Smoothfox.js";
    hash = "sha256-h3eZp18vYr8DCB21LhkoGH67Yrx3xkpSOMuWcbo1w+A=";
  };
in

lib.checkListOfEnum "usernix: modes" validModes modes

  stdenvNoCC.mkDerivation
  {
    pname = "usernix";
    version = "2026.07.09";

    buildCommand = lib.concatLines [
      "mkdir -p $out && generate() { echo \"{ \n$(cat $1 | grep \"^user_pref(\" | sort | sed -e 's/^user_pref(//g' -e 's/);.*/;/g' -e '/_user\.js\.parrot/d' -e 's/, / = /g')\n}\" > $out/$2.nix; }"
      (lib.optionalString (lib.elem "arkenfox" modes) "generate ${arkenfox} arkenfox")
      (lib.optionalString (lib.elem "betterfox" modes) "generate ${betterfox} betterfox")
      (lib.optionalString (lib.elem "fastfox" modes) "generate ${fastfox} fastfox")
      (lib.optionalString (lib.elem "peskyfox" modes) "generate ${peskyfox} peskyfox")
      (lib.optionalString (lib.elem "securefox" modes) "generate ${securefox} securefox")
      (lib.optionalString (lib.elem "smoothfox" modes) "generate ${smoothfox} smoothfox")
    ];

    meta = {
      description = "Firefox userjs configs in nix";
      homepage = "https://github.com/SchweGELBin/nur-expressions/blob/main/pkgs/usernix/default.nix";
      licese = lib.license.mit;
      maintainers = [ lib.maintainers.SchweGELBin ];
    };
  }
