{
  pkgs ? import <nixpkgs> { },
}:
{
  catspeak = pkgs.callPackage ./catspeak { };
  smoos-bot = pkgs.callPackage ./smoos/smoos-bot.nix { };
  smoos-cs = pkgs.callPackage ./smoos/smoos-cs.nix { };
  smoos-rs = pkgs.callPackage ./smoos/smoos-rs.nix { };
}
