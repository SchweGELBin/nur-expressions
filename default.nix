{
  fenix ? import (fetchTarball "https://github.com/nix-community/fenix/archive/monthly.tar.gz") { },
  pkgs ? import <nixpkgs> { },
}:

let
  rustNightly = pkgs.makeRustPlatform {
    cargo = fenix.minimal.cargo;
    rustc = fenix.minimal.rustc;
  };
in

{
  catspeak = pkgs.callPackage ./pkgs/catspeak { };
  mixbot = pkgs.callPackage ./pkgs/mixbot { rustPlatform = rustNightly; };
  smoos-bot = pkgs.callPackage ./pkgs/smoos/bot.nix { };
  smoos-cs = pkgs.callPackage ./pkgs/smoos/cs.nix { };
  smoos-rs = pkgs.callPackage ./pkgs/smoos/rs.nix { };
}
