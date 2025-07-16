{
  fenix ? import (fetchTarball "https://github.com/nix-community/fenix/archive/monthly.tar.gz") { },
  pkgs ? import <nixpkgs> { },
}:

let
  rustToolchain =
    with fenix;
    combine [
      minimal.toolchain
      targets.aarch64-unknown-linux-gnu.minimal.rust-std
      targets.x86_64-unknown-linux-gnu.minimal.rust-std
    ];
  rustNightly = pkgs.makeRustPlatform {
    cargo = rustToolchain;
    rustc = rustToolchain;
  };
in

{
  catspeak = pkgs.callPackage ./pkgs/catspeak { rustPlatform = rustNightly; };
  mixbot = pkgs.callPackage ./pkgs/mixbot { rustPlatform = rustNightly; };
  smoos-bot = pkgs.callPackage ./pkgs/smoos/bot.nix { rustPlatform = rustNightly; };
  smoos-cs = pkgs.callPackage ./pkgs/smoos/cs.nix { };
  smoos-rs = pkgs.callPackage ./pkgs/smoos/rs.nix { rustPlatform = rustNightly; };
}
