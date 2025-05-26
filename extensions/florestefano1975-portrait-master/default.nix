{ buildExtension, fetchFromGitHub, lib }:

buildExtension {
  name = "florestefano1975-portrait-master";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "florestefano1975";
    repo = "comfyui-portrait-master";
    fetchSubmodules = false;
    rev = "6be15ee04c6fa8838c47863d7922a9b69fe6af4c";
    hash = "sha256-FxMDkxDoIrzH9L/Jk4T+KNxcEvQ7DNqDVMrLO3o4CdY=";
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
