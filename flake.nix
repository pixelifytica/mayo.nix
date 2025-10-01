{
  description = "Mayo - opensource 3D CAD viewer and converter";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system: {
        mayo = nixpkgs.legacyPackages.${system}.callPackage ./derivation.nix { };
        default = self.packages.${system}.mayo;
      });
    };
}
