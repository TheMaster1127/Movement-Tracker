import cv2
import numpy as np
import requests
import time
import os
from flask import Flask, render_template, request, jsonify
import threading

# Declare the global variables
bytes = bytes()
endpoint1_return_value = "0"

app = Flask(__name__, template_folder='templates')

# Set up the motion detection thread
def motion_detection_thread():
    global bytes  # Use the global 'bytes' variable

    # Set up the video capture from the MJPEG stream
    url = "http://192.168.43.1:8585/stream.mjpeg"
    response = requests.get(url, stream=True)

    # Set up the motion detection threshold
    motion_threshold = 480

    # Define a variable to hold the previous frame
    prev_frame = None

    # Set up the screenshot directory
    screenshot_dir = "screenshots"
    if not os.path.exists(screenshot_dir):
        os.makedirs(screenshot_dir)

    # Set up a counter for consecutive motion detections
    motion_count = 0

    # Set up a variable to hold the last detection time
    last_detection_time = None

    # Loop through each frame in the stream
    for chunk in response.iter_content(chunk_size=1024):
        bytes += chunk
        a = bytes.find(b'\xff\xd8')
        b = bytes.find(b'\xff\xd9')
        if a != -1 and b != -1:
            jpg = bytes[a:b+2]
            bytes = bytes[b+2:]
            frame = cv2.imdecode(np.frombuffer(jpg, dtype=np.uint8), cv2.IMREAD_COLOR)

            # Calculate the difference between the current frame and the previous frame
            if prev_frame is not None:
                diff = cv2.absdiff(frame, prev_frame)
                gray = cv2.cvtColor(diff, cv2.COLOR_BGR2GRAY)
                blur = cv2.GaussianBlur(gray, (5, 5), 0)
                _, thresh = cv2.threshold(blur, 20, 255, cv2.THRESH_BINARY)
                dilated = cv2.dilate(thresh, None, iterations=3)
                contours, _ = cv2.findContours(dilated, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

                # Check if there is movement in the frame
                motion_detected = False
                for contour in contours:
                    if cv2.contourArea(contour) < motion_threshold:
                        continue
                    motion_detected = True
                    break

                # If there is movement, increment the motion count
                if motion_detected:
                    motion_count += 1
                else:
                    motion_count = 0

                # If there have been two or more consecutive motion detections, capture a screenshot and save it
                if motion_count >= 3:
                    print("Multiple movements detected! Saving screenshot...")

                    # Create a new folder if it has been more than 3 seconds since the last detection
                    if last_detection_time is None or time.time() - last_detection_time > 3:
                        folder_name = time.strftime("%Y-%m-%d_%H-%M-%S")
                        folder_path = os.path.join(screenshot_dir, folder_name)
                        os.makedirs(folder_path, exist_ok=True)



                        # Set the return value of endpoint1 to "1"
                        with endpoint1_lock:
                            global endpoint1_return_value
                            endpoint1_return_value = "1"


                        # Run the AutoHotkey script
                        ahk_script_path = "Camera object detection\Camera object detection.ahk"

                        # Run the AHK script using os.startfile
                        os.startfile(ahk_script_path)
                        # Wait for 500 milliseconds
                        time.sleep(0.5)

                        # Set the return value of endpoint1 back to "0"
                        with endpoint1_lock:
                            endpoint1_return_value = "0"

                    # Save the screenshot in the current folder
                    filename = f"{time.strftime('%Y-%m-%d_%H-%M-%S')}.jpg"
                    filepath = os.path.join(folder_path, filename)
                    cv2.imwrite(filepath, frame)

                    last_detection_time = time.time()
                    motion_count = 0
                else:
                    print("No movement detected")

            # Set the previous frame to the current frame
            prev_frame = frame

# Set up a lock for modifying the endpoint1_return_value
endpoint1_lock = threading.Lock()

# Start the motion detection thread
motion_detection_thread = threading.Thread(target=motion_detection_thread)
motion_detection_thread.start()

@app.route('/')
def app_route():
    return render_template('index.html')

@app.route('/endpoint1', methods=['POST'])
def endpoint1():
    request_data = request.get_json()
    print(f"Data from Hell: {request_data}")
    with endpoint1_lock:
        return endpoint1_return_value

@app.errorhandler(404)
def not_found(e):
    return "Page not found", 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
