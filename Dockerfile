FROM ubuntu:20.04
MAINTAINER Jakub Rewieński <jrewienski@gmail.com>

# Get wget and unzip
RUN  apt-get update && apt-get install -y \
     build-essential \
     libncurses5 \
     unzip \
     wget

# Fix broken
RUN apt --fix-broken install

# Download and unpack ARM GCC
WORKDIR /root/
RUN wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2
RUN tar -xf gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 -C /usr/local/
RUN rm gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2

# Download and unpack the nRF Command Line Tools
RUN wget https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-12-1/nRFCommandLineTools10121Linuxamd64.tar.gz
RUN mkdir ./nRFCommandLineTools
RUN tar -zxf nRFCommandLineTools10121Linuxamd64.tar.gz -C ./nRFCommandLineTools/
WORKDIR /root/nRFCommandLineTools
RUN dpkg -i JLink_Linux_V688a_x86_64.deb
RUN dpkg -i nRF-Command-Line-Tools_10_12_1_Linux-amd64.deb
WORKDIR /root/
RUN rm -rf nRFCommandLineTools*

# Download and unzip the nRF5 SDK
RUN wget https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v16.x.x/nRF5_SDK_16.0.0_98a08e2.zip
RUN unzip nRF5_SDK_16.0.0_98a08e2.zip -d nRF5_SDK_16.0.0_98a08e2
RUN rm nRF5_SDK_16.0.0_98a08e2.zip
RUN cd nRF5_SDK_16.0.0_98a08e2; mkdir projects;

# Set workdir to projects directory inside nRF5 SDK
WORKDIR /root/nRF5_SDK_16.0.0_98a08e2/projects
ENTRYPOINT ["/bin/bash"]   