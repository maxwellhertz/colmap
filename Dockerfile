FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
    git \
    cmake \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libboost-test-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libfreeimage-dev \
    libmetis-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libcgal-qt5-dev \
    libatlas-base-dev \
    libsuitesparse-dev

RUN mkdir -p /opt/source

# Install Ceres Solver
RUN cd /opt/source && \
    git clone https://ceres-solver.googlesource.com/ceres-solver && \
    cd ceres-solver && git checkout $(git describe --tags) && \
    mkdir build && cd build && \
    cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF && \
    make -j && make install

# Build COLMAP
RUN cd /opt/source && \
    git clone https://github.com/colmap/colmap.git && \
    cd colmap && git checkout dev && \
    mkdir build && cd build && \
    cmake .. && \
    make -j && make install