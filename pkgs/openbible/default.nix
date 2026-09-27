{
  lib,
  stdenv,
  fetchurl,
  dpkg,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "openbible";
  version = "3.4.0";

  src = fetchurl {
    url = "https://github.com/SchweGELBin/OpenBible2/releases/download/v${finalAttrs.version}/openbible-desktop.deb";
    hash = "sha256-ZMRb+AqqWzuxP4pdmgITvuBxL5tBAETPfL0Ywg3dh+Q=";
  };

  nativeBuildInputs = [ dpkg ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    cp -r opt/openbible/{bin,lib} "$out"

    runHook postInstall
  '';

  meta = {
    broken = true;
    description = "OpenBible provides the Bible with as little distractions as possible";
    homepage = "https://schwegelbin.github.io/projects/openbible/";
    changelog = "https://github.com/SchweGELBin/OpenBible2/blob/v${finalAttrs.version}/docs/CHANGELOG.md";
    license = lib.licenses.asl20;
    mainProgram = finalAttrs.pname;
    maintainers = [ lib.maintainers.SchweGELBin ];
    platforms = lib.platforms.linux;
  };
})
