{
  description = "SchweGELBin's nur-expressions";

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
      homeModules = import ./modules/home;
      nixosModules = import ./modules/nixos;
      overlays.default = import ./overlay.nix;
      packages = eachSystem (system: nixpkgs.legacyPackages.${system}.callPackage ./default.nix { });
    };
}
