from fastapi import FastAPI
from fastapi.responses import JSONResponse
import torch
import numpy as np
from pydantic import BaseModel
from transformers import RobertaTokenizer
import onnxruntime
from typing import Any

class Dto(BaseModel):
    input : Any

app = FastAPI()


tokenizer = RobertaTokenizer.from_pretrained("roberta-base")
session = onnxruntime.InferenceSession(
"roberta-sequence-classification-9.onnx")

@app.post("/predict")
def predict(dto: Dto): 
    input_ids = torch.tensor(tokenizer.encode(
        dto.input, add_special_tokens=True
    )).unsqueeze(0)

    if input_ids.requires_grad:
        input_array = input_ids.detach().cpu().numpy()
    else:
        input_array = input_ids.cpu().numpy()

    inputs = {session.get_inputs()[0].name: input_array}
    out = session.run(None, inputs)
    result = np.argmax(out)
    
    return JSONResponse(bool(result))


    