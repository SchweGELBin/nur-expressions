{
  lib,
  pkgs,
  stdenv,
}:
let
  buildXpi = lib.makeOverridable (
    {
      pname,
      version,
      src,
      addonId,
      meta,
    }:

    stdenv.mkDerivation {
      name = "${pname}-${version}";

      inherit meta src;

      preferLocalBuild = true;
      allowSubstitutes = true;

      passthru = {
        inherit addonId;
      };

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    }
  );
in

{
  behave = pkgs.callPackage ./behave.nix { inherit buildXpi; };
  darkreader = pkgs.callPackage ./darkreader.nix { inherit buildXpi; };
  firefox-color = pkgs.callPackage ./firefox-color.nix { inherit buildXpi; };
  redirector = pkgs.callPackage ./redirector.nix { inherit buildXpi; };
  skip-redirect = pkgs.callPackage ./skip-redirect.nix { inherit buildXpi; };
  stylus = pkgs.callPackage ./stylus.nix { inherit buildXpi; };
  ublock-origin = pkgs.callPackage ./ublock-origin.nix { inherit buildXpi; };
}
