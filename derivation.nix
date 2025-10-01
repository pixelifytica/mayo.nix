{
  stdenv,
  fetchFromGitHub,
  cmake,
  git,
  libsForQt5,
  opencascade-occt,
  assimp,
}:
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
    for file in $out/bin/*; do wrapProgram "$file" --prefix QT_QPA_PLATFORM : "xcb"; done
  '';
}
