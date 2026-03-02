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
    url = "https://raw.githubusercontent.com/arkenfox/user.js/cc65f3c21bc118819c9ed5840c41233e02fad833/user.js";
    hash = "sha256-JbcA1+OrZ0jRl0o5oZMMPlg7WfdSGx+7lm8+65AGNyY=";
  };
  betterfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/f1c8e3809dbd23f4f9aa1e5e70805c61734b1f14/user.js";
    hash = "sha256-2mRprNcFNiZICFsrWkyxFJdEA0Wr2ljSiQyMB9dy5rM=";
  };
  fastfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/f1c8e3809dbd23f4f9aa1e5e70805c61734b1f14/Fastfox.js";
    hash = "sha256-FYsulQP2/tZe7TN7K/2igMQ417plueYDu6uhzSFc8LM=";
  };
  peskyfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/f1c8e3809dbd23f4f9aa1e5e70805c61734b1f14/Peskyfox.js";
    hash = "sha256-ssL0IvcCbpgMsakROY4Atga1pPXKAlignu+4LbqSBYM=";
  };
  securefox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/f1c8e3809dbd23f4f9aa1e5e70805c61734b1f14/Securefox.js";
    hash = "sha256-REnbADoEd9Q9pN6xamrnr9fUh8soE3fiX/1jwf1I9Xg=";
  };
  smoothfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/f1c8e3809dbd23f4f9aa1e5e70805c61734b1f14/Smoothfox.js";
    hash = "sha256-S1zDXctpV1jNlV9DCua4fYMHfR7T34V3gQi780ShFpk=";
  };
in

lib.checkListOfEnum "usernix: modes" validModes modes

  stdenvNoCC.mkDerivation
  {
    pname = "usernix";
    version = "2026.03.02";

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
