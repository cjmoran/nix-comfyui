{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "city96-gguf";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "city96";
    repo = "ComfyUI-GGUF";
    fetchSubmodules = false;
    rev = "b3ec875a68d94b758914fd48d30571d953bb7a54";
    hash = "sha256-DdCZnRtx9svz9aNxS+HJORNYsDoWVI9DWLcMocRT268=";
  };

  propagatedBuildInputs = [
    python3.pkgs.gguf
    python3.pkgs.numpy
    python3.pkgs.safetensors
    python3.pkgs.torch
    python3.pkgs.tqdm
  ];

  meta = {
    license = lib.licenses.asl20;
  };
}
