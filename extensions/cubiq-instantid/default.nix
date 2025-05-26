{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "cubiq-instantid";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "cubiq";
    repo = "ComfyUI_InstantID";
    fetchSubmodules = false;
    rev = "72495e806bc2ab9c41581e15ccaa1bcf83c477e8";
    hash = "sha256-q8s3mHOhGu0/AOim8qolQrSfLeUAi6whyAqFTKtXKWM=";
  };

  propagatedBuildInputs = [
    python3.pkgs.insightface
    python3.pkgs.numpy
    python3.pkgs.onnxruntime
    python3.pkgs.opencv-python
    python3.pkgs.pillow
    python3.pkgs.torch
    python3.pkgs.torchvision
  ];

  postPatch = ''
    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "InstantID' \
          'CATEGORY = "instantid'
    done
  '';

  passthru = {
    check-pkgs.ignoredPackageNames = [
      "onnxruntime-gpu"
    ];
  };

  meta = {
    license = lib.licenses.asl20;
  };
}
