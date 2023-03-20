from google.cloud import storage
import tensorflow as tf
from PIL import Image
import numpy as np

model = None
interpreter = None
input_idx = None
output_idx = None

BUCKET_NAME = "gratato-model"

diseases_names = ['Grape__Black_rot', 'Grape_Esca(Black_Measles)', 'Grape__Leaf_blight(Isariopsis_Leaf_Spot)',
                  'Grape__healthy', 'Potato_Early_blight', 'Potato_Late_blight', 'Potato__healthy',
                  'Tomato__Bacterial_spot', 'Tomato_Early_blight', 'Tomato_Late_blight', 'Tomato__Leaf_Mold',
                  'Tomato__Septoria_leaf_spot', 'Tomato_Spider_mites Two-spotted_spider_mite', 'Tomato__Target_Spot',
                  'Tomato__Tomato_Yellow_Leaf_Curl_Virus', 'Tomato_Tomato_mosaic_virus', 'Tomato__healthy']


def download_blob(bucket, source_blob, download_location):
    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucket)
    blob = bucket.blob(source_blob)

    blob.download_to_filename(download_location)

    print(f"Blob {source_blob} downloaded to {download_location}.")


def predict(request):
    global model
    if model is None:
        download_blob(BUCKET_NAME, "model/my_model3.h5", "/tmp/my_model3.h5", )
        model = tf.keras.models.load_model("/tmp/my_model3.h5")

    image = request.files["file"]

    image = np.array(
        Image.open(image).convert("RGB").resize((256, 256))
    )

    image = image / 255

    img_array = np.expand_dims(image, 0)
    predictions = model.predict(img_array)

    print("Prediction :- ", predictions)

    predicted_class = diseases_names[np.argmax(predictions[0])]
    confidence = round(100 * (np.max(predictions[0])), 2)

    return {"class": predicted_class, "confidence": confidence}
