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
    rev = "eb63b5c53610943051f89bfb221ba9a62994a49b";
    hash = "sha256-2M+50tGeqc8htBlGpVgy+oDKH65UEFo/vwTI/kJe/To=";
  };

  npmDepsHash = "sha256-+Zcyqnh2iVoR2QcB+mPDCqntxIkIFZgts8B/tXhjRWM=";

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/share/comfyui
    cp --archive dist $out/share/comfyui/web

    runHook postInstall
  '';
}
