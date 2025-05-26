{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "acly-inpaint";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Acly";
    repo = "comfyui-inpaint-nodes";
    fetchSubmodules = false;
    rev = "726e16ff2742be285b3da78b73333ba6227ad234";
    hash = "sha256-r1q8U4V3nH2P1tlinOujeYvqceFa4uriVfHDoDathog=";
  };

  propagatedBuildInputs = [
    python3.pkgs.kornia
    python3.pkgs.numpy
    python3.pkgs.opencv-python
    python3.pkgs.spandrel
    python3.pkgs.torch
    python3.pkgs.tqdm
  ];

  meta = {
    license = lib.licenses.gpl3;
  };
}
