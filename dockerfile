FROM ubuntu:latest
LABEL authors="ar1ste1a"

# Install the application dependencies for hashcat
RUN mkdir /hashcat
WORKDIR /hashcat/hashcat
RUN apt update && apt install -y git  \
                              build-essential \
                              libssl-dev \
                              pkg-config \
                              libcurl4-openssl-dev \
                              libjansson-dev \
                              libgmp-dev \
                              libncurses5-dev \
                              libsqlite3-dev \
                              libbz2-dev \
                              zlib1g-dev \
                              libtinfo-dev \
                              ocl-icd-opencl-dev \
                              opencl-headers \
                              pocl-opencl-icd \
                              ocl-icd-libopencl1 \
                              clinfo \
                              && rm -rf /var/lib/apt/lists/*

# Clone the hashcat repository
RUN git clone https://github.com/hashcat/hashcat.git /hashcat

# Build the hashcat application
RUN make install

# Expose the ports for the hashcat brain server
EXPOSE 22
EXPOSE 1991

# Start the hashcat brain server
CMD ["hashcat", "--brain-server", "--brain-host=0.0.0.0", "--brain-port=1991", "--brain-password=HashCracking!"]
