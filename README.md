Imatge Docker amb entorn gràfic complet (XFCE) i Visual Studio Code instal·lat, accessible per VNC i SSH.

## 📦 Contingut

- Ubuntu 24.04
- Entorn d'escriptori XFCE4
- Visual Studio Code
- OpenSSH Server
- VNC Server (porta 5901)

🔨 Build
docker build -t developer-dev .

▶️ Execució manual:

docker run -d --name developer -p 5901:5901 -p 2124:22 developer-dev

🔑 Acceso SSH
ssh ubuntu@localhost -p 2124


Usuari: ubuntu


Contrasenya: ubuntu

🖥️ VNC Viewer
Obre VNC Viewer (RealVNC, TightVNC, etc.)

Conecta't a: localhost:5901

Contrasenya: ubuntu

📂 Directori de treball
El directori de treball per defecte és:
/home/ubuntu/workspace

🔧 Detalls tècnics
El .vnc/xstartup ha estat configurat amb startxfce4 &

VNC arrenca automàticament en iniciar el contenidor.

El VS Code s’instal·la des del paquet .deb oficial.

📌 Requisits
Docker instal·lat


Almenys 2GB RAM lliure recomanada
