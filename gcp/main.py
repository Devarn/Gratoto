from google.cloud import storage
import tensorflow as tf
from PIL import Image
import numpy as np

model = None
interpreter = None
input_idx = None
output_idx = None

BUCKET_NAME = "gratato-model"

diseases_names = ['Grape Black rot', 'Grape Esca(Black Measles)', 'Grape Leaf blight(Isariopsis Leaf Spot)',
                  'Grape healthy', 'Potato Early blight', 'Potato Late blight', 'Potato healthy',
                  'Tomato Bacterial spot', 'Tomato Early blight', 'Tomato Late blight', 'Tomato Leaf Mold',
                  'Tomato Septoria leaf spot', 'Tomato Two spotted spider mite', 'Tomato Target Spot',
                  'Tomato Tomato Yellow Leaf Curl Virus', 'Tomato Tomato mosaic virus', 'Tomato healthy', 'not_plant']


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


    img_array = np.expand_dims(image, 0)
    predictions = model.predict(img_array)

    print("Prediction :- ", predictions)

    predicted_class = diseases_names[np.argmax(predictions[0])]
    confidence = round(100 * (np.max(predictions[0])), 2)
    result=predicted_class+","+str(confidence)

    return result
