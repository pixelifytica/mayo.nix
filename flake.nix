{
  description = "Mayo - opensource 3D CAD viewer and converter";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs =
    { self, nixpkgs }:
    {
      packages.x86_64-linux = {
        mayo = nixpkgs.legacyPackages.callPackage ./derivation.nix { };
        default = self.packages.x86_64-linux.mayo;
      };
    };
}
