{ buildExtension, fetchFromGitHub, lib, python3 }:

buildExtension {
  name = "badcafecode-execution-inversion-demo";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "BadCafeCode";
    repo = "execution-inversion-demo-comfyui";
    fetchSubmodules = false;
    rev = "d9eebfaa1a6a33067e8c9108ef093b48279c4cbb";
    hash = "sha256-kjUBgIxPWgWiqa51BizT6NuwjNE+5GkrYVd0EhYXbqk=";
  };

  propagatedBuildInputs = [
    python3.pkgs.torch
  ];

  patches = [
    ./0001-use-web-directory.patch
  ];

  postPatch = ''
    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "Custom Components' \
          'CATEGORY = "components' \
        --replace-quiet \
          'CATEGORY = "InversionDemo Nodes' \
          'CATEGORY = "inversion_demo'
    done
  '';

  passthru = {
    comfyui.stateDirs = [
      "components"
    ];
  };

  meta = {
    license = lib.licenses.unfree; # not specified
  };
}
