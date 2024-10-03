import os
import sys
import time
import locale
import logging
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from PIL import Image

# Đảm bảo môi trường sử dụng UTF-8
os.environ["PYTHONIOENCODING"] = "utf-8"
sys.stdout = open(sys.stdout.fileno(), mode='w', encoding='utf-8', buffering=1)
sys.stderr = open(sys.stderr.fileno(), mode='w', encoding='utf-8', buffering=1)

# Cấu hình ghi log
logging.basicConfig(filename="auto_convert.log", level=logging.DEBUG,
                    format="%(asctime)s:%(levelname)s:%(message)s")

class ImageConversionHandler(FileSystemEventHandler):
    def __init__(self, input_folder, output_folder):
        self.input_folder = os.path.abspath(input_folder)
        self.output_folder = os.path.abspath(output_folder)

    def on_created(self, event):
        if not event.is_directory and self.is_image_file(event.src_path):
            self.convert_to_webp(event.src_path)

    def on_modified(self, event):
        if not event.is_directory and self.is_image_file(event.src_path):
            self.convert_to_webp(event.src_path)

    def is_image_file(self, file_path):
        return file_path.lower().endswith(('.png', '.jpg', '.jpeg', '.bmp', '.tiff'))

    def convert_to_webp(self, input_path):
        try:
            input_path = os.path.abspath(input_path)
            filename = os.path.basename(input_path)
            output_filename = f"{os.path.splitext(filename)[0]}.webp"
            output_path = os.path.join(self.output_folder, output_filename)

            if not os.path.exists(output_path):
                with Image.open(input_path) as img:
                    img.save(output_path, 'webp')
                logging.info(f"Converted: {input_path} -> {output_path}")
                print(f"Converted: {input_path} -> {output_path}")
            else:
                logging.info(f"Skipped (already exists): {output_path}")
                print(f"Skipped (already exists): {output_path}")
        except Exception as e:
            logging.error(f"Error converting {input_path}: {e}")
            print(f"Error converting {input_path}: {e}")

def main(input_folder, output_folder):
    try:
        locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')
    except locale.Error:
        print("Locale 'en_US.UTF-8' not available, using default locale")
    
    input_folder = os.path.abspath(input_folder)
    output_folder = os.path.abspath(output_folder)
    event_handler = ImageConversionHandler(input_folder, output_folder)
    observer = Observer()
    observer.schedule(event_handler, input_folder, recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

def convert_existing_files(input_folder, output_folder):
    for filename in os.listdir(input_folder):
        file_path = os.path.join(input_folder, filename)
        if os.path.isfile(file_path) and ImageConversionHandler.is_image_file(None, file_path):
            ImageConversionHandler(input_folder, output_folder).convert_to_webp(file_path)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python convert_2_webp.py <input_folder> <output_folder>")
    else:
        input_folder = sys.argv[1]
        output_folder = sys.argv[2]
        convert_existing_files(input_folder, output_folder)  # Thêm dòng này
        main(input_folder, output_folder)

