{
  description = "Mayo the opensource 3D CAD viewer and converter";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {

      packages.x86_64-linux.mayo =
        with nixpkgs.legacyPackages.x86_64-linux;
        stdenv.mkDerivation rec {
          pname = "mayo";
          version = "0.9.0";
          src = fetchFromGitHub {
            owner = "fougue";
            repo = pname;
            tag = "v${version}";
            hash = "sha256-A2ODbbOyoWIhKOWGzSQS2gUF8kpWlN8hN8CdeumAUps=";
          };
          nativeBuildInputs = [
            cmake
            git
            libsForQt5.qtbase
            libsForQt5.wrapQtAppsHook
            opencascade-occt
            assimp
          ];
          buildPhase = ''
            cmake . -DMayo_BuildPluginAssimp=ON
            cmake --build . --config Release
          '';
          installPhase = ''
            mkdir -p $out/bin/
            mv mayo $out/bin/
            mv mayo-conv $out/bin/
          '';
        };

      packages.x86_64-linux.default = self.packages.x86_64-linux.mayo;

    };
}
