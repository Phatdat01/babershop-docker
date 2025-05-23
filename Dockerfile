FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
ENV TORCH_CUDA_ARCH_LIST="8.6"

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.10 python3-pip python3.10-dev \
    build-essential cmake git curl wget unzip ffmpeg ninja-build \
    libgl1 libglib2.0-0 libsm6 libxrender1 libxext6 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/python3.10 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip

WORKDIR /app

# Clone source
# RUN git clone https://github.com/Phatdat01/babershop.git /app
# 1scHopIzZSXPZB03hX_b0qrviroHDKMgN

# Sao chép mã nguồn vào container

COPY ./babershop /app

# Cài Python requirements
RUN pip install --force-reinstall --no-cache-dir numpy

RUN pip3 install torch==2.3.1 torchvision==0.18.1 torchaudio==2.3.1 --index-url https://download.pytorch.org/whl/cu118

RUN pip3 install ninja

RUN pip3 install -r /app/requirement.txt

# Cổng mặc định
EXPOSE 5000

# Lệnh khởi chạy
CMD ["python3", "-u", "api.py"]