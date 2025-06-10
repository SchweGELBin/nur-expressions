{
  description = "nur-expressions";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      systems = lib.systems.flakeExposed;
      eachSystem = lib.genAttrs systems;
    in
    {
      packages = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          nur = pkgs.callPackage ./default.nix { };
          default = pkgs.callPackage ./default.nix { };
        }
      );
    };
}
