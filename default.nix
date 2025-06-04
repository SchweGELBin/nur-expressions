{
  pkgs ? import <nixpkgs> { },
}:
{
  catspeak = pkgs.callPackage ./pkgs/catspeak { };
  smoos-bot = pkgs.callPackage ./pkgs/smoos/bot.nix { };
  smoos-cs = pkgs.callPackage ./pkgs/smoos/cs.nix { };
  smoos-rs = pkgs.callPackage ./pkgs/smoos/rs.nix { };
}
