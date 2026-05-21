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
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/8a93c27d7034876d3fb5487a67a03910e4f45cdd/user.js";
    hash = "sha256-vfLIkNTKQhjJLZ0ruR/oEvzs9RxX3T9JmgzcXKQgt8s=";
  };
  fastfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/8a93c27d7034876d3fb5487a67a03910e4f45cdd/Fastfox.js";
    hash = "sha256-YffmgqqZkarDErtO9FD+XM1FgwUcRF4W0NRzwzCHY78=";
  };
  peskyfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/8a93c27d7034876d3fb5487a67a03910e4f45cdd/Peskyfox.js";
    hash = "sha256-mP2nlFdbMyxBolymXdsUaa669A0RQaWCYoIKPhWQn6A=";
  };
  securefox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/8a93c27d7034876d3fb5487a67a03910e4f45cdd/Securefox.js";
    hash = "sha256-bQysEJphLIPNWL2n7wasbOinfy6ho8ONsSnhsteg4pM=";
  };
  smoothfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/8a93c27d7034876d3fb5487a67a03910e4f45cdd/Smoothfox.js";
    hash = "sha256-S1zDXctpV1jNlV9DCua4fYMHfR7T34V3gQi780ShFpk=";
  };
in

lib.checkListOfEnum "usernix: modes" validModes modes

  stdenvNoCC.mkDerivation
  {
    pname = "usernix";
    version = "2026.05.21";

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
