{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "city96-gguf";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "city96";
    repo = "ComfyUI-GGUF";
    fetchSubmodules = false;
    rev = "a2b75978fd50c0227a58316619b79d525b88e570";
    hash = "sha256-nsAnkzapDWUFtuNnroHqcX4PR5fUWkXXIH+zn5K3aqo=";
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
