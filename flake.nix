{
  description = "ComfyUI as a Nix expression";

  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    # See description text:
    # https://github.com/nix-community/poetry2nix/pull/1921
    curl-minimal = {
      url = "github:NixOS/nixpkgs?ref=pull/425701/head";
    };

    poetry2nix = {
      url = "github:a-sup/poetry2nix";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "curl-minimal";
        systems.follows = "flake-utils/systems";
      };
    };
  };

  outputs = inputs: let
    mkComfyuiPackages = pkgs:
      pkgs.callPackage ./scope.nix {
        poetry2nix = inputs.poetry2nix.lib.mkPoetry2Nix {inherit pkgs;};
      };
  in
    {
      lib = {
        inherit mkComfyuiPackages;
      };

      overlays.default = final: prev: {
        comfyuiPackages = mkComfyuiPackages prev;
      };
    }
    // inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

        comfyuiPackages = mkComfyuiPackages pkgs;

        mkPackageEntry = path: {
          name = builtins.concatStringsSep "-" path;
          value = pkgs.lib.getAttrFromPath path comfyuiPackages;
        };

        packages = builtins.listToAttrs (
          pkgs.lib.flatten (
            # (map (name: mkPackageEntry [name]) ["krita-with-extensions"])
            # ++
            (
              map
              (
                platform: (
                  map
                  (
                    name:
                      mkPackageEntry [
                        platform
                        name
                      ]
                  )
                  [
                    "comfyui"
                    "comfyui-with-extensions"
                  ]
                )
              )
              [
                "cuda"
                "rocm"
              ]
            )
          )
        );
      in {
        formatter = pkgs.nixpkgs-fmt;

        devShells.default = pkgs.mkShell {
          name = "default";
          buildInputs = [
            pkgs.bash
            pkgs.coreutils
            pkgs.findutils
            pkgs.git
            pkgs.just
            pkgs.nix-prefetch-git
            pkgs.nixpkgs-fmt
            pkgs.prefetch-npm-deps
            pkgs.yapf
            (pkgs.python3.withPackages (p: [p.nix-prefetch-github]))
          ];
        };

        inherit packages;

        checks =
          packages
          // {
            nix-comfyui-sources =
              pkgs.runCommand "nix-comfyui-sources"
              {
                nativeBuildInputs = [
                  pkgs.just
                  pkgs.nixpkgs-fmt
                  pkgs.yapf
                ];
              }
              ''
                cd ${./.}
                just check-fmt
                touch $out
              '';

            cuda-run-check-pkgs = comfyuiPackages.cuda.run-check-pkgs;
            rocm-run-check-pkgs = comfyuiPackages.rocm.run-check-pkgs;
          };

        legacyPackages = comfyuiPackages;
      }
    );
}
