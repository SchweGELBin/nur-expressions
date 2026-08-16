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
    url = "https://raw.githubusercontent.com/arkenfox/user.js/47e212e06db2a1533b8aa5a4395468b1ac516d85/user.js";
    hash = "sha256-RKZGO42fV2kNgH3IVf/8yHNIKKJSTtgx7SE/PASrEqQ=";
  };
  betterfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/9ae9dd17a9afaef635b566d9375dd3c9330fe181/user.js";
    hash = "sha256-ri/6ZTL9mSbaSwl4jgdcB+GPnoX9zVMLkXAmkaOSLZM=";
  };
  fastfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/9ae9dd17a9afaef635b566d9375dd3c9330fe181/Fastfox.js";
    hash = "sha256-MbDJNJRb5doOWa+cfY/d1VBlYuHtI/2oJOH72eOvhkc=";
  };
  peskyfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/9ae9dd17a9afaef635b566d9375dd3c9330fe181/Peskyfox.js";
    hash = "sha256-FwrcnlDHyHPrJGEH37qz3G9bHNpcX0wfI6bigG6uUPA=";
  };
  securefox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/9ae9dd17a9afaef635b566d9375dd3c9330fe181/Securefox.js";
    hash = "sha256-4gWBNEPPHnh7y+VMKdgBo0SJZWVdmJb4dDr+c6weidU=";
  };
  smoothfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/9ae9dd17a9afaef635b566d9375dd3c9330fe181/Smoothfox.js";
    hash = "sha256-h3eZp18vYr8DCB21LhkoGH67Yrx3xkpSOMuWcbo1w+A=";
  };
in

lib.checkListOfEnum "usernix: modes" validModes modes

  stdenvNoCC.mkDerivation
  {
    pname = "usernix";
    version = "2026.08.16";

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
