FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Actualizar e instalar paquetes bàsics
RUN sed -i 's|http://archive.ubuntu.com/ubuntu|http://mirror.hetzner.com/ubuntu/packages|g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y --fix-missing\
    sudo \
    iproute2 \
    xfce4 xfce4-goodies \
    tightvncserver \
    openssh-server \
    wget curl git \
    python3 python3-pip python3-venv \
    postgresql-client \
    && apt-get clean

# Crear usuario normal 'ubuntu' amb accés sudo
RUN id -u ubuntu && userdel -r ubuntu || echo "User ubuntu does not exist" && \
    useradd -m -s /bin/bash ubuntu && \
    echo "ubuntu:ubuntu" | chpasswd && \
    usermod -aG sudo ubuntu


# Preparar servidor SSH
RUN mkdir /var/run/sshd

# Instal·lar VSCode
RUN wget https://update.code.visualstudio.com/latest/linux-deb-x64/stable -O vscode.deb && \
    apt-get install -y ./vscode.deb && \
    rm vscode.deb

RUN apt-get update && apt-get install -y \
    libx11-xcb1 libxcb-dri3-0 libxss1 libasound2t64 libgtk-3-0 \
    dbus-x11 x11-xserver-utils

# Copiar configuració del VNC (bàsica per l’usuari)
USER ubuntu
RUN mkdir -p /home/ubuntu/.vnc && \
    echo "ubuntu" | vncpasswd -f > /home/ubuntu/.vnc/passwd && \
    chmod 600 /home/ubuntu/.vnc/passwd

# Tornar a root per arrencar serveis
USER root

# Exposem ports: 5901 (VNC), 22 (SSH)
EXPOSE 5901 22

# Script d’inici (poc elegant però funcional)
CMD service ssh start && \
    su - ubuntu -c "vncserver :1 -geometry 1280x800 -depth 24" && \
    tail -f /dev/null
