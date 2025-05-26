{
  basePyproject,
  lib,
}:
basePyproject.override {
  content = {
    tool.poetry.dependencies = {
      pytorch-triton-rocm = {
        version = "~3.3.0";
        source = "torch-rocm";
      };
      taichi = "*";
      torch = {
        version = "~2.7.0+rocm6.3";
        source = "torch-rocm";
      };
      torchaudio = {
        version = "~2.7.0";
        source = "torch-rocm";
      };
      torchvision = {
        version = "~0.22.0";
        source = "torch-rocm";
      };
    };

    tool.poetry.source = lib.singleton {
      name = "torch-rocm";
      url = "https://download.pytorch.org/whl/rocm6.3";
      priority = "explicit";
    };
  };
}
