#!/usr/bin/env bash

# Đường dẫn đến script Python và các thư mục đầu vào và đầu ra
SCRIPT_PATH="$(dirname "$(readlink -f "$0")")/convert_2_webp.py"
INPUT_FOLDER="$HOME/Downloads/input_folder"
OUTPUT_FOLDER="$HOME/Downloads/output_folder"
VENV_DIR="$(dirname "$(readlink -f "$0")")/venv"

# Tạo các thư mục nếu chưa tồn tại
mkdir -p "$INPUT_FOLDER"
mkdir -p "$OUTPUT_FOLDER"

# Hàm kiểm tra và cài đặt Python nếu chưa có
install_python() {
    if ! command -v python3 &> /dev/null; then
        echo "Python3 not found. Installing Python3..."
        sudo apt update
        sudo apt install -y python3 python3-venv python3-pip
    else
        echo "Python3 is already installed."
    fi

    if ! command -v pip3 &> /dev/null; then
        echo "pip3 not found. Installing pip3..."
        sudo apt install -y python3-pip
    else
        echo "pip3 is already installed."
    fi
}

# Cài đặt Python nếu chưa có
install_python

# Tạo virtual environment nếu chưa tồn tại
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
fi

# Kích hoạt virtual environment
source "$VENV_DIR/bin/activate"

# Kiểm tra môi trường ảo đã kích hoạt thành công chưa
echo "Đang sử dụng Python tại: $(which python3)"

# Đảm bảo pip trong môi trường ảo được sử dụng để cài đặt thư viện
"$VENV_DIR/bin/pip" install --upgrade pip
"$VENV_DIR/bin/pip" install Pillow watchdog

# Chạy script Python từ môi trường ảo
echo "Đang chạy script Python..."
"$VENV_DIR/bin/python3" "$SCRIPT_PATH" "$INPUT_FOLDER" "$OUTPUT_FOLDER"

# Script sẽ dừng hẳn sau khi thực hiện xong hành động
echo "Script đã hoàn thành và dừng lại."

# Hủy kích hoạt virtual environment
deactivate

