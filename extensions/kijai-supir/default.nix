{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "kijai-supir";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "kijai";
    repo = "ComfyUI-SUPIR";
    fetchSubmodules = false;
    rev = "29f2e8be0e9c32197ab6cf3a79a8c5776867d8f0";
    hash = "sha256-IxRbDKR1nvByQHIVuXdPFfVWccdhxdnYUl6PLJ9C6EY=";
  };

  propagatedBuildInputs = [
    python3.pkgs.accelerate
    python3.pkgs.einops
    python3.pkgs.numpy
    python3.pkgs.omegaconf
    python3.pkgs.open-clip-torch
    python3.pkgs.packaging
    python3.pkgs.pillow
    python3.pkgs.pytorch-lightning
    python3.pkgs.requests
    python3.pkgs.safetensors
    python3.pkgs.scipy
    python3.pkgs.torch
    python3.pkgs.torchvision
    python3.pkgs.tqdm
    python3.pkgs.transformers
  ];

  postPatch = ''
    find -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "SUPIR' \
          'CATEGORY = "supir'
    done
  '';

  passthru = {
    check-pkgs.ignoredModuleNames = [
      "^modules$"
      "^pytorch_fid$"
      "^xformers(\\..+)?$"
    ];
  };

  meta = {
    license = lib.licenses.unfree; # non-commercial
  };
}
