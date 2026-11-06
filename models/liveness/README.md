# Model 10: Liveness (model card)

| | |
|---|---|
| **Job** | Catches a printed photo or a phone screen held up to the camera at the selfie step. A spoof sends the case to video KYC (`R-KYC-01`). |
| **Type** | Ready-made: Minivision's [Silent-Face-Anti-Spoofing](https://github.com/minivision-ai/Silent-Face-Anti-Spoofing) (Apache-2.0), two **MiniFASNet** networks, converted to ONNX |
| **Files** | `weights/2.7_80x80_MiniFASNetV2.onnx` and `weights/4_0_0_80x80_MiniFASNetV1SE.onnx` (1.7 MB each, in the repo), `weights/LICENSE-minivision.txt` |
| **Version** | `minifasnet-v2+v1se` |
| **Owner** | Backend member |

## How it works

1. Model 9's YuNet detector finds the face box.
2. Two crops are taken around it, **2.7×** and **4×** the size of the face, kept inside the photo and resized to **80×80**. The wider crop shows the edges of a phone or a printed page.
3. Each network looks at its crop as raw 0–255 BGR pixels (as Minivision trained them) and gives three probabilities. Class 1 is a real face; 0 and 2 are kinds of spoof.
4. The two outputs are added. The face is **live** when class 1 wins. `score` is its average probability.

## Conversion

`convert.py` loads the published `.pth` files (after checking their SHA-256), builds the network from `minifasnet.py` (Minivision's file, unchanged, with credit) and exports ONNX. The ONNX outputs match PyTorch to within 0.000002. The engine runs the ONNX files with ONNX Runtime, so **PyTorch is only needed to convert**, never at run time.

## Checks

- `tests/test_liveness.py` checks the ONNX files still give the logits PyTorch gave at conversion, that crops stay inside the photo, and the result format.
- On Minivision's three sample photos: the real face scores **0.9999 live**; the printed photo (0.77 spoof) and the photo on a phone screen (0.997 spoof) are both caught. That test runs when those photos are on the machine (`NIRNAY_FACE_SAMPLES`); they are not in the repo.

## Limits

- **Not tested by the team yet.** The model table's check is "team tries spoofing it". Before a demo, try printed photos, a phone screen and a laptop screen under different light, and note what gets through.
- Passive liveness can't stop a good 3D mask or a deepfake video injected into the camera feed. A lender adds active checks (blink, turn) and device-integrity checks.
- Trained on Minivision's own data, mostly East Asian faces. Check false spoof rates on Indian faces.
