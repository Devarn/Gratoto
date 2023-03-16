from fastapi import FastAPI, UploadFile, File
import uvicorn
import numpy as np
from io import BytesIO
from PIL import Image
import tensorflow as tf
import keras
from keras.models import save_model

app = FastAPI()


MODEL=tf.keras.models.load_model("../model", compile=False)
MODEL.compile
CLASS_NAMES=["Early Blight", "Late Blight", "Healthy"]


def read_file_as_image(data) -> np.ndarray:
    image = np.array(Image.open(BytesIO(data)))
    return image


@app.get("/ping")
async def ping():
    return "hello im dev"


@app.post("/predict")
async def predict(
        file: UploadFile = File(...)
):
    img_bytes = read_file_as_image(await file.read())
    img_batch = np.expand_dims(img_bytes, 0)
    predictions = MODEL.predict(img_batch)
    predicted_class= CLASS_NAMES[np.argmax(predictions[0])]
    conifdence =np.max(predictions[0])
    return {
        'class':predicted_class,
        'confidecne':float(conifdence)
    }



if __name__ == "__main__":
    uvicorn.run(app, host='localhost', port=8000)
