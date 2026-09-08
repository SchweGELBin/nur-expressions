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
    url = "https://raw.githubusercontent.com/arkenfox/user.js/9d129dbe53e7484c7a8ddbe00eff606f3d8d6c17/user.js";
    hash = "sha256-of9aF3bHbXdpB8cUMb07bQ2aP0OEePyV3SJgcGl4SKo=";
  };
  betterfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/067172a4b0dc90e78e5b8b94d9abfe6430c6a7be/user.js";
    hash = "sha256-OKlxx7FSJZh7rybdmLiEv7EUUxtPao8uDigfsDUtUkA=";
  };
  fastfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/067172a4b0dc90e78e5b8b94d9abfe6430c6a7be/Fastfox.js";
    hash = "sha256-MbDJNJRb5doOWa+cfY/d1VBlYuHtI/2oJOH72eOvhkc=";
  };
  peskyfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/067172a4b0dc90e78e5b8b94d9abfe6430c6a7be/Peskyfox.js";
    hash = "sha256-FwrcnlDHyHPrJGEH37qz3G9bHNpcX0wfI6bigG6uUPA=";
  };
  securefox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/067172a4b0dc90e78e5b8b94d9abfe6430c6a7be/Securefox.js";
    hash = "sha256-C4MUBqqN/RgRAzag3xpUeHnn0l1AOG49M0wvCXdA9fk=";
  };
  smoothfox = fetchurl {
    url = "https://raw.githubusercontent.com/yokoffing/Betterfox/067172a4b0dc90e78e5b8b94d9abfe6430c6a7be/Smoothfox.js";
    hash = "sha256-h3eZp18vYr8DCB21LhkoGH67Yrx3xkpSOMuWcbo1w+A=";
  };
in

lib.checkListOfEnum "usernix: modes" validModes modes

  stdenvNoCC.mkDerivation
  {
    pname = "usernix";
    version = "2026.09.08";

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
