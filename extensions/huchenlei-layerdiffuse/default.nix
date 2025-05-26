{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "huchenlei-layerdiffuse";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "huchenlei";
    repo = "ComfyUI-layerdiffuse";
    fetchSubmodules = false;
    rev = "b4f6a9e024064a4489f774a8b91049ce0b606ea3";
    hash = "sha256-yQBsFf903zP2C1e3/Y+142dH4Ysg4ORj87a5c52w4B4=";
  };

  propagatedBuildInputs = [
    python3.pkgs.diffusers
    python3.pkgs.einops
    python3.pkgs.numpy
    python3.pkgs.opencv-python
    python3.pkgs.packaging
    python3.pkgs.torch
    python3.pkgs.tqdm
  ];

  passthru = {
    check-pkgs.ignoredModuleNames = [
      "^diffusers.models.unet_2d_blocks$"
    ];
  };

  meta = {
    license = lib.licenses.asl20;
  };
}
