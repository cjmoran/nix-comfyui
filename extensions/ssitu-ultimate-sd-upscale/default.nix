{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "ssitu-ultimate-sd-upscale";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "ssitu";
    repo = "ComfyUI_UltimateSDUpscale";
    fetchSubmodules = true;
    rev = "95fb26043d341c79246f0e137aabc64c19d67d37";
    hash = "sha256-MUfdfCMNYfpIxvL87hMMJc6A80lmp46F1r63vocBtDQ=";
  };

  propagatedBuildInputs = [
    python3.pkgs.numpy
    python3.pkgs.pillow
    python3.pkgs.torch
    python3.pkgs.torchvision
  ];

  passthru = {
    check-pkgs.ignoredModuleNames = [
      "^gradio$"
      "^modules(\\..+)?$"
      "^repositories$"
      "^usdu_patch$"
    ];
  };

  meta = {
    license = lib.licenses.gpl3;
  };
}
