{
  pkgs ? import <nixpkgs> { },
}:

{
  bible4tui = pkgs.callPackage ./pkgs/bible4tui { };
  catspeak = pkgs.callPackage ./pkgs/catspeak { };
  mixbot = pkgs.callPackage ./pkgs/mixbot { };
  smoos-bot = pkgs.callPackage ./pkgs/smoos/bot.nix { };
  smoos-cs = pkgs.callPackage ./pkgs/smoos/cs.nix { };
  smoos-rs = pkgs.callPackage ./pkgs/smoos/rs.nix { };
  website = pkgs.callPackage ./pkgs/website { };
}
