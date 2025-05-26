{
  pkgs,
  poetry2nix,
}:
pkgs.lib.makeScope pkgs.newScope (self:
    (import ./environment pkgs self)
    // {
      inherit poetry2nix;

      inherit (import ./toml.nix) toTOML;

      inherit
        (import ./packages {
          inherit (self) callPackage comfyui-frontend;
        })
        check-pkgs
        comfyui
        comfyui-frontend
        comfyui-unwrapped
        ;

      buildExtension =
        self.callPackage
        (
          {
            emptyPyproject,
            python3,
          }: attrs: let
            pyproject = emptyPyproject.override {
              content = {
                tool.poetry = {inherit (attrs) name version;};
              };
            };
          in
            python3.pkgs.buildPythonPackage (attrs
              // {
                format = "pyproject";

                nativeBuildInputs = [
                  python3.pkgs.poetry-core
                ];

                postPatch = ''
                  cp ${pyproject} pyproject.toml
                  ${attrs.postPatch or ""}
                '';

                passthru =
                  {
                    originalName = attrs.name;
                  }
                  // (attrs.passthru or {});
              })
        )
        {};

      extensions = import ./extensions {
        inherit (self) callPackage;
      };

      comfyui-with-extensions = self.comfyui.override {
        extensions = builtins.attrValues self.extensions;
      };

      run-check-pkgs =
        self.callPackage
        (
          {
            check-pkgs,
            runCommand,
          }:
            runCommand "run-check-pkgs"
            {
              nativeBuildInputs = [
                check-pkgs
              ];
            }
            ''
              check-pkgs
              touch $out
            ''
        )
        {};
    })
