import cv2
import numpy as np

# Load the trained recognizer model
recognizer = cv2.face.LBPHFaceRecognizer_create()
recognizer.read("trainer.yml")

# Load Haar Cascade for face detection
face_cascade = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")

# Start video capture
cap = cv2.VideoCapture(0)

# Set font for the text on the screen
font = cv2.FONT_HERSHEY_SIMPLEX

print("\n [INFO] Starting video stream. Press 'q' to quit.")

while True:
    # Read frame-by-frame
    ret, frame = cap.read()
    if not ret:
        print("Failed to grab frame")
        break

    # Convert frame to grayscale
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect faces in the grayscale frame
    faces = face_cascade.detectMultiScale(
        gray,
        scaleFactor=1.2,
        minNeighbors=5,
        minSize=(100, 100),
    )

    for (x, y, w, h) in faces:
        # Recognize the face using the recognizer
        id, confidence = recognizer.predict(gray[y:y + h, x:x + w])

        # Check if confidence is low enough to consider it a match
        if confidence < 100:
            name = f"User {id}"
            confidence_text = f"{round(100 - confidence)}%"
        else:
            name = "Unknown"
            confidence_text = f"{round(100 - confidence)}%"

        # Draw a rectangle around the face
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

        # Display the name and confidence level
        cv2.putText(frame, name, (x + 5, y - 5), font, 1, (255, 255, 255), 2)
        cv2.putText(frame, confidence_text, (x + 5, y + h - 5), font, 1, (255, 255, 0), 1)

    # Display the resulting frame
    cv2.imshow("Face Recognition", frame)

    # Press 'q' to exit the video stream
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the capture and close all OpenCV windows
cap.release()
cv2.destroyAllWindows()
