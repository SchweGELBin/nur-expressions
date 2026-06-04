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
    url = "https://raw.githubusercontent.com/arkenfox/user.js/8fe9905c35a1025d1e6df69479f7625585fd956d/user.js";
    hash = "sha256-5KszxpFImRdc9wNeDlei1/CKyIfY+VfxGZ5+Sbvn4z4=";
  };
  betterfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/6787a5c335df2f7923f5c00acba74e356943dfbc/user.js";
    hash = "sha256-WJVO5HIOZhDN9zGY1caAu9jMoLB/40ooFDr0feh+87E=";
  };
  fastfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/6787a5c335df2f7923f5c00acba74e356943dfbc/Fastfox.js";
    hash = "sha256-XunzFhZ+KMIYRSdOpE3Z6rUyDzTw4cLNNF8mD1Bv4q8=";
  };
  peskyfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/6787a5c335df2f7923f5c00acba74e356943dfbc/Peskyfox.js";
    hash = "sha256-TdWaNzLfzSfoWgvg63m+wKwcYwEdptqSKjLRIgvgiB8=";
  };
  securefox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/6787a5c335df2f7923f5c00acba74e356943dfbc/Securefox.js";
    hash = "sha256-bQysEJphLIPNWL2n7wasbOinfy6ho8ONsSnhsteg4pM=";
  };
  smoothfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/6787a5c335df2f7923f5c00acba74e356943dfbc/Smoothfox.js";
    hash = "sha256-h3eZp18vYr8DCB21LhkoGH67Yrx3xkpSOMuWcbo1w+A=";
  };
in

lib.checkListOfEnum "usernix: modes" validModes modes

  stdenvNoCC.mkDerivation
  {
    pname = "usernix";
    version = "2026.06.04";

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
