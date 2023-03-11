import tf as tf
import uvicorn
from fastapi import FastAPI, UploadFile, File
import uvicorn
import numpy as np
from io import BytesIO
from PIL import Image
import tensorflow as tf

app = FastAPI()

MODEL = tf.keras.


def read_file_as_image(data) -> np.ndarray:
    image = np.array(Image.ope(BytesIO(data)))
    return image


@app.get("/ping")
async def ping():
    return "hello im dev"


@app.post("/predict")
async def predict(
        file: UploadFile = File(...)
):
    img_bytes = read_file_as_image(await file.read())

    return


if __name__ == "__main__":
    uvicorn.run(app, host='localhost', port=8000)
