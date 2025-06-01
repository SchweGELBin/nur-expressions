{
  fetchFromGitHub,
  lib,
  rustPlatform,
}:

# https://github.com/SchweGELBin/smoos/blob/main/smoos-bot/default.nix

let
  pin = import ./smoos-pin.nix;
  repo = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "smoos";
    tag = "v${pin.version}";
    hash = pin.gitHubHash;
  };
in

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "smoos-bot";
  version = pin.version;

  src = "${repo}/${finalAttrs.pname}";
  cargoHash = pin.botCargoHash;

  meta = {
    description = "Super Mario Odyssey: Online Server - Bot";
    homepage = "https://github.com/SchweGELBin/smoos";
    changelog = "https://github.com/SchweGELBin/smoos/blob/v${finalAttrs.version}/docs/CHANGELOG.md";
    license = lib.licenses.agpl3Only;
    mainProgram = finalAttrs.pname;
    maintainers = with lib.maintainers; [ SchweGELBin ];
  };
})
