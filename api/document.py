
import os
import tempfile

from fastapi import APIRouter, UploadFile, File, Form, HTTPException

from models.document_ai.ocr import extract_text
from models.document_ai.extract_fields import extract_fields
from models.document_ai.verification import verify_applicant

router = APIRouter(
    prefix="/api/v1/documents",
    tags=["Document AI"]
)

@router.post("/ocr")
async def ocr_document(
    file: UploadFile = File(...),
    declared_name: str = Form(default=""),
    declared_dob: str = Form(default="")
):
    if file.content_type not in ["image/jpeg", "image/png"]:
        raise HTTPException(400, "Only JPG and PNG images are supported")

    content = await file.read()

    if not content:
        raise HTTPException(400, "Empty file")

    if len(content) > 5 * 1024 * 1024:
        raise HTTPException(413, "Maximum file size is 5 MB")

    suffix = ".png" if file.content_type == "image/png" else ".jpg"
    temp_path = None

    try:
        with tempfile.NamedTemporaryFile(delete=False, suffix=suffix) as temp:
            temp.write(content)
            temp_path = temp.name

        extracted_text = extract_text(temp_path)

        structured_result = extract_fields(extracted_text)
        extracted_data = structured_result["extracted_fields"]

        declared_data = {
            "name": declared_name,
            "date_of_birth": declared_dob
        }

        verification = verify_applicant(
            declared_data,
            extracted_data
        )

        return {
            "filename": file.filename,
            "ocr_status": "processed",
            "extracted_text": extracted_text,
            **structured_result,
            "verification": verification
        }

    except ValueError as e:
        raise HTTPException(400, detail=str(e))

    except Exception as e:
        raise HTTPException(500, detail=str(e))

    finally:
        if temp_path and os.path.exists(temp_path):
            os.remove(temp_path)
