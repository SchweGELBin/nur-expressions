{
  description = "nur-expressions";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      fenix,
      nixpkgs,
    }:
    let
      inherit (nixpkgs) lib;
      systems = lib.systems.flakeExposed;
      eachSystem = lib.genAttrs systems;
    in
    {
      homeModules = import ./modules/home;
      nixosModules = import ./modules/nixos;
      packages = eachSystem (
        system:
        nixpkgs.legacyPackages.${system}.callPackage ./default.nix { fenix = fenix.packages.${system}; }
      );
    };
}
