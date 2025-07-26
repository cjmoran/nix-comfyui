{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "ssitu-ultimate-sd-upscale";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "ssitu";
    repo = "ComfyUI_UltimateSDUpscale";
    fetchSubmodules = true;
    rev = "627c871f14532b164331f08d0eebfbf7404161ee";
    hash = "sha256-ogIMcxYlFGFIZvOtCmfgxGAuYvXbg9utH2qQTlf8fLI=";
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
