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
    rev = "927773f5531b2af77767350ae5d50035150b3e70";
    hash = "sha256-PKQp6e26S+gA230YoKvAGiiubaQg66u6yb0WL2nn2EY=";
  };

  npmDepsHash = "sha256-AO7HKbF5mAMc1TbUV9f9EXyBv5Yr8SB85P1X3s3z0jk=";

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/share/comfyui
    cp --archive dist $out/share/comfyui/web

    runHook postInstall
  '';
}
