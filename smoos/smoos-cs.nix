{
  buildDotnetModule,
  fetchgit,
  lib,
}:

# https://github.com/SchweGELBin/smoos/blob/main/smoos-cs/default.nix

let
  pin = import ./smoos-pin.nix;
  repo = fetchgit {
    url = "https://github.com/SchweGELBin/smoos";
    tag = "v${pin.version}";
    hash = pin.gitHash;
    fetchSubmodules = true;
  };
in

buildDotnetModule (finalAttrs: {
  pname = "smoos-cs";
  version = pin.version;

  src = "${repo}/${finalAttrs.pname}/csharp-server";
  projectFile = "Server/Server.csproj";
  nugetDeps = ./deps.json;

  postUnpack = ''
    sed -i  "s/net6.0/net8.0/g" csharp-server/Server/Server.csproj
    sed -i  "s/net6.0/net8.0/g" csharp-server/Shared/Shared.csproj
  '';

  meta = {
    description = "Super Mario Odyssey: Online Server - C#";
    homepage = "https://github.com/SchweGELBin/smoos";
    changelog = "https://github.com/SchweGELBin/smoos/blob/v${finalAttrs.version}/docs/CHANGELOG.md";
    license = lib.licenses.agpl3Only;
    mainProgram = finalAttrs.pname;
    maintainers = with lib.maintainers; [ SchweGELBin ];
  };
})
