# Model 9: Face match (model card)

| | |
|---|---|
| **Job** | Checks the selfie against the photo on the customer's ID: the UIDAI eKYC photo, or the face on the uploaded Aadhaar or PAN card. A mismatch sends the case to video KYC (`R-KYC-01`). |
| **Type** | Ready-made, from the [OpenCV model zoo](https://github.com/opencv/opencv_zoo), run with OpenCV's own `FaceDetectorYN` and `FaceRecognizerSF` |
| **Models** | **YuNet** face detector (`face_detection_yunet_2023mar.onnx`, 0.2 MB, MIT) and **SFace** recogniser (`face_recognition_sface_2021dec.onnx`, 37 MB, Apache-2.0) |
| **Version** | `sface-2021dec+yunet-2023mar` |
| **Status** | Checked on LFW: **98.7% accuracy, no false accepts, 2.6% false rejects** on the 1,000 test pairs |
| **Owner** | Backend member |

## Why not InsightFace or DeepFace

The model table listed InsightFace or DeepFace. We use the **SFace + YuNet pair**, which DeepFace also offers, but call OpenCV directly:
- **Licence.** InsightFace's pretrained weights are for non-commercial research only; SFace and YuNet are Apache-2.0 and MIT, so a lender could ship them.
- **Size.** No TensorFlow or PyTorch at run time: OpenCV is already installed for the other models.

## How it works

1. YuNet finds every face and its five landmarks (eyes, nose, mouth corners). Photos are shrunk to 960 px on the long side first. The largest face is used.
2. SFace aligns that face and turns it into 128 numbers.
3. Two faces are the same person when the **cosine similarity is at least 0.363**, the threshold OpenCV publishes for SFace on LFW.

In the engine the match runs as soon as both photos exist, whichever comes second: the selfie (`/selfie`) or an Aadhaar/PAN card with a face (`/documents`). Until then the app shows "Photo match: done when you upload your Aadhaar or PAN card".

## Results on LFW (`reports/lfw_pairs.json`)

LFW's standard verification pairs: half are the same person, half are not. `evaluate.py` downloads LFW (about 230 MB) through scikit-learn.

| Pairs | Faces found | Accuracy | False accepts | False rejects |
|---|---|---|---|---|
| Train, 2,200 | all | 99.2% | **0.0%** | 1.6% |
| Test, 1,000 | all | 98.7% | **0.0%** | 2.6% |

**What this means for Nirnay:** at this threshold an impostor is very unlikely to pass, and about 1 in 40 genuine customers is sent to video KYC. That's the right trade for a lender.

```bash
.venv/Scripts/python -m models.face_match.evaluate K:/tools/downloads/lfw
```

## Limits

- **LFW is not Indian selfies.** LFW photos are news photos of public figures, mostly well lit and frontal. False rejects will be higher on dim phone selfies, and the team should test across skin tones before going live.
- **ID card photos are small and printed.** A face under 60 px is flagged as `too_small`. The sandbox's sample ID cards carry a photo box, not a face, so the face match waits (`matchPending`) in demos. Real eKYC returns the UIDAI photo.
- A twin or a close relative can pass. Liveness (model 10) and the other KYC checks are the other layers.

## Get the weights

```bash
.venv/Scripts/python -m backend.fetch
```

This downloads both files from OpenCV's Hugging Face mirror and checks their SHA-256. Git ignores them (SFace is 37 MB).
