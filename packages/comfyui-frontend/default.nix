{ buildNpmPackage
, fetchFromGitHub
,
}:
buildNpmPackage {
  name = "comfyui-frontend";

  src = fetchFromGitHub {
    owner = "Comfy-Org";
    repo = "ComfyUI_frontend";
    fetchSubmodules = false;
    rev = "a70d69cbd26be18ef0626e75b9b32870a50f1902";
    hash = "sha256-eJAxB0kX91fCPex2FD/otkAs6lTiDTkfO1bPcpewHlQ=";
  };

  npmDepsHash = "sha256-AO7HKbF5mAMc1TbUV9f9EXyBv5Yr8SB85P1X3s3z0jk=";

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/share/comfyui
    cp --archive dist $out/share/comfyui/web

    runHook postInstall
  '';
}
