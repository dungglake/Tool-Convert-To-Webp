import os
import time
import json
import logging
from PIL import Image
import subprocess
import sys

# Configure logging
logging.basicConfig(filename="auto_convert.log", level=logging.DEBUG,
                    format="%(asctime)s:%(levelname)s:%(message)s")

def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

try:
    from PIL import Image
except ImportError:
    install("Pillow")

input_folder = r"C:\%Usersname%\Downloads\input folder"
output_folder = r"C:\%Usersname%\Downloads\output folder"
status_file = "converted_files.json"

def load_converted_files():
    if os.path.exists(status_file):
        with open(status_file, "r") as f:
            return set(json.load(f))
    return set()

def save_converted_files(converted_files):
    with open(status_file, "w") as f:
        json.dump(list(converted_files), f)

def convert_to_webp(input_path, output_path):
    try:
        with Image.open(input_path) as img:
            img.save(output_path, "webp")
            logging.info(f"Converted {input_path} to {output_path}")
    except Exception as e:
        logging.error(f"Failed to convert {input_path} to WebP: {e}")

def monitor_folder():
    if not os.path.exists(input_folder):
        os.makedirs(input_folder)
        logging.info(f"Created input folder: {input_folder}")
    
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
        logging.info(f"Created output folder: {output_folder}")

    converted_files = load_converted_files()
    while True:
        current_files = set(os.listdir(input_folder))
        output_files = set(os.listdir(output_folder))
        for file_name in current_files:
            if file_name.lower().endswith(('png', 'jpg', 'jpeg', 'bmp', 'tiff')):
                output_file_name = os.path.splitext(file_name)[0] + ".webp"
                if output_file_name not in output_files:
                    input_path = os.path.join(input_folder, file_name)
                    output_path = os.path.join(output_folder, output_file_name)
                    convert_to_webp(input_path, output_path)
                    converted_files.add(file_name)

        save_converted_files(converted_files)
        time.sleep(5)

if __name__ == "__main__":
    logging.info("Starting monitor_folder")
    monitor_folder()
