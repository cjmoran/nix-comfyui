{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "acly-tooling";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Acly";
    repo = "comfyui-tooling-nodes";
    fetchSubmodules = false;
    rev = "5ef2fddc1ba5fc2dc38286a29f97268be4e25343";
    hash = "sha256-NZhcyGplF363s6vxHaylzcvJ/rKbVDLgyW6bz4Rx/Bc=";
  };

  propagatedBuildInputs = [
    python3.pkgs.aiohttp
    python3.pkgs.argostranslate
    python3.pkgs.gguf
    python3.pkgs.kornia
    python3.pkgs.numpy
    python3.pkgs.pillow
    python3.pkgs.requests
    python3.pkgs.torch
    python3.pkgs.tqdm
    python3.pkgs.transformers
  ];

  passthru = {
    comfyui.stateDirs = [
      "custom_nodes/acly-tooling/safetychecker"
    ];

    comfyui.prepopulatedStateFiles = [
      "custom_nodes/acly-tooling/safetychecker/config.json"
      "custom_nodes/acly-tooling/safetychecker/preprocessor_config.json"
    ];
  };

  meta = {
    license = lib.licenses.gpl3;
  };
}
