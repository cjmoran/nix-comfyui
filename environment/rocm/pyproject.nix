{
  basePyproject,
  lib,
}:
basePyproject.override {
  content = {
    tool.poetry.dependencies = {
      pytorch-triton-rocm = {
        version = "~3.3.1";
        source = "torch-rocm";
      };
      taichi = "*";
      torch = {
        version = "~2.7.1+rocm6.3";
        source = "torch-rocm";
      };
      torchaudio = {
        version = "~2.7.1";
        source = "torch-rocm";
      };
      torchvision = {
        version = "~0.22.1";
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
