{ buildExtension, fetchFromGitHub, lib }:

buildExtension {
  name = "florestefano1975-portrait-master";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "florestefano1975";
    repo = "comfyui-portrait-master";
    fetchSubmodules = false;
    rev = "e73a479908f40289293d9891642c57270a7ca9ef";
    hash = "sha256-alQQWz/MZ4DmkB0KFUZuQDCYdbSiYYnCqJfvoeFDcXM=";
  };

  postPatch = ''
    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "AI WizArt/Portrait Master' \
          'CATEGORY = "portrait_master' \
        --replace-quiet "'random 🎲'" "'Random'"
    done
  '';

  meta = {
    license = lib.licenses.gpl3;
  };
}
