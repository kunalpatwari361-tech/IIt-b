"""Convert Minivision's published liveness weights from PyTorch to ONNX (run once).

The engine runs the ONNX files with ONNX Runtime, so PyTorch is only needed here.

    .venv/Scripts/python -m models.liveness.convert <folder with the two .pth files>

The .pth files come from
https://github.com/minivision-ai/Silent-Face-Anti-Spoofing/tree/master/resources/anti_spoof_models
(Apache-2.0). Their SHA-256 sums are checked before loading, because torch.load
unpickles the file.
"""
from __future__ import annotations

import hashlib
import sys
from collections import OrderedDict
from pathlib import Path

WEIGHTS = Path(__file__).resolve().parent / "weights"
SOURCES = {
    "2.7_80x80_MiniFASNetV2.pth": ("MiniFASNetV2", "a5eb02e1843f19b5386b953cc4c9f011c3f985d0ee2bb9819eea9a142099bec0"),
    "4_0_0_80x80_MiniFASNetV1SE.pth": ("MiniFASNetV1SE", "84ee1d37d96894d5e82de5a57df044ef80a58be2b218b5ed7cdfd875ec2f5990"),
}


def convert(src_dir: Path, out_dir: Path = WEIGHTS) -> list[Path]:
    import torch

    from . import minifasnet

    out = []
    for name, (arch, sha) in SOURCES.items():
        path = Path(src_dir) / name
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        if digest != sha:
            raise ValueError(f"{name}: SHA-256 {digest} does not match the published file")
        net = getattr(minifasnet, arch)(conv6_kernel=(5, 5))  # 80x80 input: ((80 + 15) // 16,) * 2
        state = torch.load(path, map_location="cpu", weights_only=True)
        state = OrderedDict((k[7:] if k.startswith("module.") else k, v) for k, v in state.items())
        net.load_state_dict(state)
        net.eval()
        target = Path(out_dir) / name.replace(".pth", ".onnx")
        torch.onnx.export(net, torch.zeros(1, 3, 80, 80), str(target), input_names=["image"],
                          output_names=["logits"], dynamic_axes={"image": {0: "n"}, "logits": {0: "n"}},
                          opset_version=17, dynamo=False)
        out.append(target)
        print(f"wrote {target}")
    return out


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("Usage: python -m models.liveness.convert <folder with the .pth files>")
    convert(Path(sys.argv[1]))
