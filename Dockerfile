FROM debian:latest

ARG UNAME=user
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
RUN usermod -aG dialout $UNAME

RUN bash -c "apt -y update"
RUN bash -c "apt -y install build-essential"
RUN bash -c "apt -y install libncurses-dev"
RUN bash -c "apt -y install bison"
RUN bash -c "apt -y install flex"
RUN bash -c "apt -y install clang"
RUN bash -c "apt -y install minicom"
RUN bash -c "apt -y install wget"
RUN bash -c "apt -y install tar"
RUN bash -c "apt -y install unzip"

RUN bash -c "wget https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-LlCjWuAbzH/9.3.1.2/msp430-gcc-9.3.1.11_linux64.tar.bz2"
RUN bash -c "tar -xf msp430-gcc-9.3.1.11_linux64.tar.bz2"

RUN bash -c "wget https://dr-download.ti.com/software-development/software-programming-tool/MD-szn5bCveqt/1.03.20.00/MSPFlasher-1_03_20_00-linux-x64-installer.zip"
RUN bash -c "unzip MSPFlasher-1_03_20_00-linux-x64-installer.zip"
RUN bash -c "chmod +x MSPFlasher-1.3.20-linux-x64-installer.run"
RUN bash -c "./MSPFlasher-1.3.20-linux-x64-installer.run --mode unattended --prefix /mspflasher"
RUN bash -c "chmod a+rx -R /mspflasher/MSP430Flasher"


USER $UNAME
RUN echo PATH="\$PATH:/msp430-gcc-9.3.1.11_linux64/bin" >> ~/.bashrc
RUN echo PATH="\$PATH:/mspflasher" >> ~/.bashrc
RUN echo export\ LD_LIBRARY_PATH="/mspflasher" >> ~/.bashrc
WORKDIR /uk
CMD bash