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
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/8bd2f5d72e8caf26f861ba2c45de16db8f0ec36d/user.js";
    hash = "sha256-prmJFuPkfVsAN23oP1apQZHpqFoVrpQrWasqgTAha3w=";
  };
  fastfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/8bd2f5d72e8caf26f861ba2c45de16db8f0ec36d/Fastfox.js";
    hash = "sha256-KV9bveCIBiBqe5CsI3A/lo2EY5ziDW1WXuTA4eFTaX0=";
  };
  peskyfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/8bd2f5d72e8caf26f861ba2c45de16db8f0ec36d/Peskyfox.js";
    hash = "sha256-FwrcnlDHyHPrJGEH37qz3G9bHNpcX0wfI6bigG6uUPA=";
  };
  securefox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/8bd2f5d72e8caf26f861ba2c45de16db8f0ec36d/Securefox.js";
    hash = "sha256-bQysEJphLIPNWL2n7wasbOinfy6ho8ONsSnhsteg4pM=";
  };
  smoothfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/8bd2f5d72e8caf26f861ba2c45de16db8f0ec36d/Smoothfox.js";
    hash = "sha256-h3eZp18vYr8DCB21LhkoGH67Yrx3xkpSOMuWcbo1w+A=";
  };
in

lib.checkListOfEnum "usernix: modes" validModes modes

  stdenvNoCC.mkDerivation
  {
    pname = "usernix";
    version = "2026.06.17";

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
