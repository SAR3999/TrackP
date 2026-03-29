import cv2
import numpy as np
from PIL import Image
import os

# Path for face image database
path = "dataset"

# Create LBPH face recognizer
recognizer = cv2.face.LBPHFaceRecognizer_create()

# Load Haar Cascade for face detection
detector = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")


# Function to get the images and label data from the dataset
def getImagesAndLabels(path):
    # Get all file paths in the dataset directory
    imagePaths = [os.path.join(path, f) for f in os.listdir(path)]
    faceSamples = []
    ids = []

    # Iterate through each file in the dataset
    for imagePath in imagePaths:
        # Convert the image to grayscale
        PIL_img = Image.open(imagePath).convert("L")
        img_numpy = np.array(PIL_img, "uint8")

        # Extract the user ID from the filename
        id = int(os.path.split(imagePath)[-1].split(".")[1])

        # Detect faces in the image
        faces = detector.detectMultiScale(img_numpy)

        # For each face detected, append the face region and user ID
        for (x, y, w, h) in faces:
            faceSamples.append(img_numpy[y: y + h, x: x + w])
            ids.append(id)

    return faceSamples, ids


print("\n[INFO] Training faces. It will take a few seconds. Wait ...")

# Get faces and IDs from the dataset
faces, ids = getImagesAndLabels(path)

# Train the recognizer with the faces and corresponding IDs
recognizer.train(faces, np.array(ids))

# Save the trained model to a file
recognizer.write("trainer.yml")

# Output the number of faces trained
print("\n[INFO] {0} faces trained. Exiting Program".format(len(np.unique(ids))))
