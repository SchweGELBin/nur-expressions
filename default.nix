{
  pkgs ? import <nixpkgs> { },
}:
{
  catspeak = pkgs.callPackage ./catspeak { };
  smoos-bot = pkgs.callPackage ./smoos/smoos-bot { };
  smoos-cs = pkgs.callPackage ./smoos/smoos-cs { };
  smoos-rs = pkgs.callPackage ./smoos/smoos-rs { };
}
