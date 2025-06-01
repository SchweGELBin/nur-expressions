{
  fetchFromGitHub,
  lib,
  rustPlatform,
  versionCheckHook,
}:

# https://github.com/SchweGELBin/catspeak/blob/main/default.nix

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "catspeak";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "SchweGELBin";
    repo = "catspeak";
    tag = "v${finalAttrs.version}";
    hash = "sha256-6KdPi3VS0kuyziGz2tZLsMLjC5vObB5ePTTxf/gED+c=";
  };
  cargoHash = "sha256-YlngOAFvlkdsYBJxlfL4cnaVuSry/dQnkINd1miYx4A=";

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "--version";

  meta = {
    description = "Cowsay like program of a speaking cat";
    homepage = "https://github.com/SchweGELBin/catspeak";
    changelog = "https://github.com/SchweGELBin/catspeak/blob/v${finalAttrs.version}/docs/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = finalAttrs.pname;
    maintainers = with lib.maintainers; [ SchweGELBin ];
  };
})
