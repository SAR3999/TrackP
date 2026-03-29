# TrackP: Finding Missing People Using AI/ML
TrackP is an Artificial Intelligence and Machine Learning–based surveillance system designed to identify missing persons using facial recognition, OpenCV, and real-time alert mechanisms. The system integrates with CCTV networks to automate the search process and notify authorities instantly when a match is detected.

How to Run:
1) Start XAMPP Server - Apache and MySQLlogo
2) Run App.Py
   - Admin: E-mail: admin@gmail.com   Password: 123
   - Add Stations (Email & Password set by Admin)
   - When Login By a Station, Add Missing People Details (You Can Update it)
   - Logout
4) Run Camera Script
   - If Missing Person in a database and Person seen in webcam are matched, then alert is sent to the police station

🚀 Key Features
🔍 AI-Based Facial Recognition
Uses OpenCV-based face detection and feature extraction
Compares detected faces with a registered missing persons database
Works in real-time surveillance feeds

🎥 Live CCTV Integration
Connects with live video streams
Continuously scans individuals in public areas
Low-latency processing for efficient monitoring

🔔 Automated Alerts & Notifications
Generates instant alerts when a match is found
Sends notifications to authorities/guardians (SMS/Email/API-based)
Includes face image, location, and timestamp in alerts

📁 Missing Person Database
Stores details like name, age, images, last-seen locations
Easy CRUD operations (Add, Update, Delete Profiles)
Supports multiple image samples per person

🧠 Machine Learning Model
Uses face encoding and feature vectors for identity matching
Optimized for accuracy and low false positives
Works efficiently on moderate hardware

🛡️ Security & Privacy Focused
Encrypted storage for images and personal data
Access-controlled dashboard for authorized users

🧩 System Architecture
Input Layer – Live CCTV feed / video input
Face Detection Module – OpenCV Haar-Cascade / DNN
Feature Extraction – LBP / HOG / Face Encodings
Database Matching – Compare embeddings with database
Alert Module – Triggers real-time notification
Dashboard – View matches, logs, and analytics

💻 Tech Stack
Python
OpenCV
NumPy, Pandas
Flask 
MySQL database
