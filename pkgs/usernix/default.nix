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
    url = "https://raw.githubusercontent.com/arkenfox/user.js/2e88889602d5a7aa19972a2e0fe4e0f7eac2cecf/user.js";
    hash = "sha256-I5u32jiigCch3/KFRYu0NWWDrP01uD0zUKGhTm0famw=";
  };
  betterfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/eee6e58b2b0ee10a59efb6586a5db07ae181d8c7/user.js";
    hash = "sha256-ZpWvGPD/nzOrYln+cnm3j/T02zsNHEsI053rEuPhQxQ=";
  };
  fastfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/eee6e58b2b0ee10a59efb6586a5db07ae181d8c7/Fastfox.js";
    hash = "sha256-sUXA1/SB+dPw89GMEROWrwrUD3zNhhIsHI5PGAbNGRc=";
  };
  peskyfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/eee6e58b2b0ee10a59efb6586a5db07ae181d8c7/Peskyfox.js";
    hash = "sha256-ZrSE66p4vgG4YtdEzVnaks0U9sNzOfvZN+TTdvdKyYQ=";
  };
  securefox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/eee6e58b2b0ee10a59efb6586a5db07ae181d8c7/Securefox.js";
    hash = "sha256-+378JSYIzz2paoR2J3+Hh2ENtPb6bIwd/R7HeLtPzDM=";
  };
  smoothfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/eee6e58b2b0ee10a59efb6586a5db07ae181d8c7/Smoothfox.js";
    hash = "sha256-S1zDXctpV1jNlV9DCua4fYMHfR7T34V3gQi780ShFpk=";
  };
in

lib.checkListOfEnum "usernix: modes" validModes modes

  stdenvNoCC.mkDerivation
  {
    pname = "usernix";
    version = "2026.01.13";

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
