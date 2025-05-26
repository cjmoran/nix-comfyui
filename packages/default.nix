{
  callPackage,
  comfyui-frontend,
}: {
  check-pkgs =
    callPackage ./check-pkgs {};

  comfyui = callPackage ./comfyui {
    bwrapArgs = [];
    commandLineArgs = [];
    extensions = [];
    prepopulatedStateFiles = [];
    stateDirs = [];
  };

  comfyui-frontend =
    callPackage ./comfyui-frontend {};

  comfyui-unwrapped =
    callPackage ./comfyui-unwrapped {};
}
