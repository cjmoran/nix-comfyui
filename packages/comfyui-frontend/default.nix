{
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage {
  name = "comfyui-frontend";

  src = fetchFromGitHub {
    owner = "Comfy-Org";
    repo = "ComfyUI_frontend";
    fetchSubmodules = false;
    rev = "9e137d99249433bd81f8779e835e33c4afb54669";
    hash = "sha256-u1D6NvIHfoS0GitLkt8kfEQUNzK7aODsi923My8V2K8=";
  };

  npmDepsHash = "sha256-K6g/daRHzxU7Gpy+NHZw67HPQFAUTElGiN34PqwT2qI=";

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/share/comfyui
    cp --archive dist $out/share/comfyui/web

    runHook postInstall
  '';
}
