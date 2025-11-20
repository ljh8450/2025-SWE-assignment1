FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
    
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /darknet
RUN git clone https://github.com/pjreddie/darknet.git . \
	&& sed -i 's/OPENCV=0/OPENCV=1/' Makefile \
	&& make

RUN wget https://pjreddie.com/media/files/yolov3.weights

COPY run_yolo.sh /run_yolo.sh
RUN chmod +x /run_yolo.sh
ENTRYPOINT ["/run_yolo.sh"]
