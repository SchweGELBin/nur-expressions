{
  pkgs ? import <nixpkgs> { },
}:
{
  catspeak = pkgs.callPackage ./pkgs/catspeak { };
  mc-mixbot = pkgs.callPackage ./pkgs/mc-mixbot { };
  smoos-bot = pkgs.callPackage ./pkgs/smoos/bot.nix { };
  smoos-cs = pkgs.callPackage ./pkgs/smoos/cs.nix { };
  smoos-rs = pkgs.callPackage ./pkgs/smoos/rs.nix { };
}
