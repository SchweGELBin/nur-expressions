{
  pkgs ? import <nixpkgs> { },
}:
{
  catspeak = pkgs.callPackage ./catspeak { };
  smoos-bot = pkgs.callPackage ./smoos/bot.nix { };
  smoos-cs = pkgs.callPackage ./smoos/cs.nix { };
  smoos-rs = pkgs.callPackage ./smoos/rs.nix { };
}
