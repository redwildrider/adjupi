Basic Setup
===========
1  ls
    2  hostname
    3  hostname -s homepi
    4  hostname homepi
    5  sudo hostname homepi
    6  passwd
    7  ls
    8  arecord -l
    9  arecord --device=hw:1,0 test.wav
   10  arecord --help
   11  arecord --device=hw:1,0 --format=s16_le test.wav
   12  ls
   13  hostname homepi
   14  sudo hostname homepi
   15  sudo reboot
   16  hostname homepi
   17  sudo hostname homepi
   18  nano /etc/hostname
   19  sudo nano /etc/host.conf
   20  sudo nano /etc/hostname
   21  sudo nano /etc/hosts
   22  sudo nano /etc/hosts.allow
   23  sudo apt update && apt upgrade -y
   24  sudo apt update && sudo apt upgrade -y
   25  sudo reboot
   26  ls
   27  rm test.wav

Audio
=====

Beim Audio kann es zu einigen Problemen mit alsa kommen. Einige bekannte Probleme können folgendermaßen vermieden werden:

1. Audiogeräte einstecken
2. Device-IDs feststellen:
    - arecord -l
    - aplay -l
3. .asound - Datei konfigurieren: pcm hw für cm.mic und pcm.speaker entsprechend anpassen.fourier

```nano ~/.asoundrc```
```

pcm.!default {
  type asym
  capture.pcm "mic"
  playback.pcm "speaker"
}

pcm.mic {
  type plug
  slave {
    pcm "hw:1,0"
  }
}

pcm.speaker {
  type plug
  slave {
    pcm "hw:2,0"
  }
}
```

SoPaRe
======
 
   28  sudo apt-get update
   29  sudo apt-get install build-essential python-pyaudio python-numpy python-scipy python-matplotlib
   30  cd
   31  mkdir dev
   32  cd dev
   33  git clone https://github.com/bishoph/sopare.git
   34  sudo apt install git
   35  git clone https://github.com/bishoph/sopare.git
   36  cd sopare
   37  mkdir tokens
   38  mkdir samples
   39  python sopare.py -u
   40  python test/test_audio.py
   41  nano config/default.ini
   42  ./sopare.py -v -t test
   43  ./sopare.py -c
   44  ./sopare.py -l
   45  nano config/default.ini
   46  ./sopare.py -v -t test
   47  ./sopare.py -c
   48  ./sopare.py -l
   49  rm dict/*.raw
   50  ./sopare.py -d "*"
   51  nano config/default.ini
   52  ./sopare.py -v -t test
   53  nano config/default.ini
   54  ./sopare.py -v -t test
   55  ./sopare.py -c
   56  ./sopare.py -l
   57  nano config/default.ini
   58  ./sopare.py -l
   59  nano config/default.ini
   60  rm dict/*.raw
   61  ./sopare.py -d "*"
   62  python test/test_audio.py
   63  nano config/default.ini
   64  ./sopare.py -v -t test
   65  ./sopare.py -c
   66  ./sopare.py -l
   67  nano config/default.ini
   68  ./sopare.py -l
   69  nano config/default.ini
   70  ./sopare.py -l
   71  ./sopare.py -v -t audio
   72  ./sopare.py -c
   73  ./sopare.py -l
   74  ./sopare.py -v -t an
   75  ./sopare.py -c
   76  ./sopare.py -l
   77  ./sopare.py -v -t aus
   78  ./sopare.py -c
   79  ./sopare.py -l
   80  history
   81  aplay -l
   82  aplay --device hw:2,0 test.wav
   83  aplay --device=hw:2,0 test.wav
   84  aplay test.wav
   85  aplay --device=hw:2,0 test.wav
   86  arecord -f S24_LE -c 2 -r 192000 -d 20 test.wav
   87  arecord -f S24_LE -c 2 -r 192000 -d 10 test.wav
   88  arecord -f S24_LE -c 2 -r 192000 --device=hw:1,0 test.wav
   89  arecord -f S16_LE -c 2 -r 192000 --device=hw:1,0 test.wav
   90  arecord -f S16_LE -c 1 -r 192000 --device=hw:1,0 test.wav
   91  arecord -f S16_LE -c 1 -r 48000 --device=hw:1,0 test.wav
   92  aplay --device=hw:2,0 test.wav
   93  aplay --device=hw:2,0 -c 1 test.wav
   94  arecord -d 10 -f cd -t wav test.wav
   95  arecord --device=hw:1,0 -f cd -t wav test.wav
   96  arecord --device=hw:1,0 -f cd -t wav -c 1 test.wav
   97  arecord --device=hw:1,0 -f cd -t wav -c 1 -r 48000 test.wav
   98  aplay --device=hw:2,0 -f cd -t wav -c 1 -r 48000 test.wav
   99  nano ~/.asoundrc
  100  aplay -f cd -t wav -c 1 -r 48000 test.wav
  101  arecord -f cd -t wav -c 1 -r 48000 test.wav
  102  aplay -f cd -t wav -c 1 -r 48000 test.wav
  103  ./sopare.py -l
  104  history

Raspotify
=========

```
sudo apt install -y apt-transport-https curl
curl -sSL https://dtcooper.github.io/raspotify/key.asc | sudo apt-key add -v -
echo 'deb https://dtcooper.github.io/raspotify raspotify main' | sudo tee /etc/apt/sources.list.d/raspotify.list
sudo apt update && sudo apt upgrade -y

sudo apt install raspotify
```

Configuration:

```sudo nano /etc/default/raspotify```

- name
- bitrate
- hw device

```
sudo systemctl restart raspotify
```

Zigbee and MQTT
===============

```
sudo apt install -y mosquitto mosquitto-clients
sudo systemctl enable mosquitto.service

sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs git make g++ gcc
sudo git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt
sudo chown -R pi:pi /opt/zigbee2mqtt
cd /opt/zigbee2mqtt
npm ci
```

Configuration:

```nano /opt/zigbee2mqtt/data/configuration.yaml```

 - base_topic
 -   disable_led: true (under serial)
 - port (eventually)

Start:
```
cd /opt/zigbee2mqtt
npm start
```

Create daemon:

```sudo nano /etc/systemd/system/zigbee2mqtt.service```
```
[Unit]
Description=zigbee2mqtt
After=network.target

[Service]
ExecStart=/usr/bin/npm start
WorkingDirectory=/opt/zigbee2mqtt
StandardOutput=inherit
StandardError=inherit
Restart=always
User=pi

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl enable zigbee2mqtt.service
```

AdjuPi
======

