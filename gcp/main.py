import google.cloud
import storage
import tensorflow as tf
from PIL import Image
import numpy as np

BUCKET_NAME = "gratato-tf-model"
class_names = ['Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot',
               'Corn_(maize)___Common_rust_',
               'Corn_(maize)___Northern_Leaf_Blight',
               'Corn_(maize)___healthy',
               'Grape___Black_rot',
               'Grape___Esca_(Black_Measles)',
               'Grape___Leaf_blight_(Isariopsis_Leaf_Spot)',
               'Grape___healthy',
               'Pepper,_bell___Bacterial_spot',
               'Pepper,_bell___healthy',
               'Potato___Early_blight',
               'Potato___Late_blight',
               'Potato___healthy',
               'Tomato___Bacterial_spot',
               'Tomato___Early_blight',
               'Tomato___Late_blight',
               'Tomato___Leaf_Mold',
               'Tomato___Septoria_leaf_spot',
               'Tomato___Spider_mites Two-spotted_spider_mite',
               'Tomato___Target_Spot',
               'Tomato___Tomato_Yellow_Leaf_Curl_Virus',
               'Tomato___Tomato_mosaic_virus',
               'Tomato___healthy']

model = None


def download_blob(bucket_name, source_blob_name, destination_file_name):
    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucket_name)
    blob = bucket.blob(source_blob_name)
    blob.download_to_filename(destination_file_name)


def predict(request):
    global model
    if model is not None:
        download_blob(BUCKET_NAME, "models/disease_model.h5", "/tmp/disease_model.h5")
        model = tf.keras.load_model("/tmp/disease_model.h5")

    image = request.files["file"]

    image = np.array(Image.open(image).convert("RGB").resize((256, 256)))
    image = image / 255
    img_array = tf.expand_dims(image, 0)

    predictions = model.predict(img_array)
    print(predictions)

    predictions = class_names[np.argmax(predictions[0])]
    confidence = round(100 * (np.max(predictions[0])), 2)

    return {"class": predictions, "confidence": confidence}
