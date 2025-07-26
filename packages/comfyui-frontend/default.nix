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
    rev = "e3628ed1568a24f90e92c7d5ded46af075eb7337";
    hash = "sha256-APKNS7GaxGZfgzJNsMdmIIl0+M4cKWA5a9/or1GPfWQ=";
  };

  npmDepsHash = "sha256-zgUYkjyo3GKmH9foBjZF3WfnPmzTLo3ii4hU8+zgFpc=";

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/share/comfyui
    cp --archive dist $out/share/comfyui/web

    runHook postInstall
  '';
}
