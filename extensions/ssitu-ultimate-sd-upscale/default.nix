{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "ssitu-ultimate-sd-upscale";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "ssitu";
    repo = "ComfyUI_UltimateSDUpscale";
    fetchSubmodules = true;
    rev = "a351b3f8c6e157feb993ca89881199393a02cde3";
    hash = "sha256-3X7Bp1+fsyULKFe++O6Tdc3Swh24cftNEz9s7ckoCYs=";
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
