{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "ellangok-post-processing";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "EllangoK";
    repo = "ComfyUI-post-processing-nodes";
    fetchSubmodules = false;
    rev = "c49a05254795403648f2c1774b6f5ea39f96e7d5";
    hash = "sha256-/85bl8UH8jmbrgamub942iR4oKxfCZbyhcyWON8wYV4=";
  };

  propagatedBuildInputs = [
    python3.pkgs.numpy
    python3.pkgs.opencv-python
    python3.pkgs.pillow
    python3.pkgs.torch
  ];

  postPatch = ''
    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "postprocessing' \
          'CATEGORY = "image/postprocessing'
    done
  '';

  meta = {
    license = lib.licenses.gpl3;
  };
}
