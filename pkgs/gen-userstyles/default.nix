{
  stdenv,
  fetchurl,
  lib,
  jq,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gen-userstyles";
  version = "2026.01.09";

  src = fetchurl {
    url = "https://github.com/SchweGELBin/catppuccin-userstyles/releases/download/${finalAttrs.version}/import.json";
    hash = "sha256-HxkhYxD/3xwsaiSmE7bPm3RLHj/FrgFbdlaaY7N1B8M=";
  };

  dontUnpack = true;

  buildInputs = [ jq ];

  installPhase = ''
    runHook preInstall
    install -Dm 644 $src $out/import.json
    jq -c '{dbInChromeStorage: true} + reduce (.[1:] | to_entries[]) as $item ({}; . + {("style-\($item.key + 1)"): $item.value})' $src > $out/storage.js
    runHook postInstall
  '';

  meta = {
    broken = true;
    description = "Generate Stylus Userstyles";
    homepage = "https://github.com/SchweGELBin/nur-expressions/blob/main/pkgs/gen-userstyles/default.nix";
    licese = lib.license.mit;
    maintainers = [ lib.maintainers.SchweGELBin ];
  };
})

/*
  # Future note as buildDenoPackage isn't available in nixpkgs (yet)
  buildDenoPackage {
    ...
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "userstyles";
      rev = "2687d34339bef91e285b786e089223395ea80385";
      hash = "sha256-oAByRn6syjCFpRnljVybhd8UDde9YNgNjxrsjQtXd+I=";
    };

    buildPhase = "deno task ci:stylus-import";
    ...
  }
*/
