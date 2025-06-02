{
  pkgs ? import <nixpkgs> { },
}:
{
  catspeak = pkgs.callPackage ./pkgs/catspeak { };
  smoos-bot = pkgs.callPackage ./pkgs/smoos/smoos-bot { };
  smoos-cs = pkgs.callPackage ./pkgs/smoos/smoos-cs { };
  smoos-rs = pkgs.callPackage ./pkgs/smoos/smoos-rs { };
}
