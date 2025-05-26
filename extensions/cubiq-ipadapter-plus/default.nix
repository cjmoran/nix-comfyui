{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "cubiq-ipadapter-plus";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "cubiq";
    repo = "ComfyUI_IPAdapter_plus";
    fetchSubmodules = false;
    rev = "a0f451a5113cf9becb0847b92884cb10cbdec0ef";
    hash = "sha256-Ft9WJcmjzon2tAMJq5na24iqYTnQWEQFSKUElSVwYgw=";
  };

  propagatedBuildInputs = [
    python3.pkgs.einops
    python3.pkgs.insightface
    python3.pkgs.pillow
    python3.pkgs.torch
    python3.pkgs.torchvision
  ];

  meta = {
    license = lib.licenses.gpl3;
  };
}
