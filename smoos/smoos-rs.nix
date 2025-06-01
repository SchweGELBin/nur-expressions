{
  fetchgit,
  lib,
  rustPlatform,
}:

# https://github.com/SchweGELBin/smoos/blob/main/smoos-rs/default.nix

let
  pin = import ./smoos-pin.nix;
  repo = fetchgit {
    url = "https://github.com/SchweGELBin/smoos";
    tag = "v${pin.version}";
    hash = pin.gitHash;
    fetchSubmodules = true;
  };
in

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "smoos-rs";
  version = pin.version;

  src = "${repo}/${finalAttrs.pname}/rust-server";
  cargoHash = pin.rsCargoHash;

  meta = {
    description = "Super Mario Odyssey: Online Server - Rust";
    homepage = "https://github.com/SchweGELBin/smoos";
    changelog = "https://github.com/SchweGELBin/smoos/blob/v${finalAttrs.version}/docs/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = finalAttrs.pname;
    maintainers = with lib.maintainers; [ SchweGELBin ];
  };
})
