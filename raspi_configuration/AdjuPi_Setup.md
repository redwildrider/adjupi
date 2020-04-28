Basic Setup
===========
Update everything:

```
sudo apt update && sudo apt upgrade -y
sudo reboot
```

Set new password for user pi:

```
passwd
```


Set hostname: (replace raspberrypi in files)

```
hostname adjupi
```

```sudo nano /etc/hostname```

```sudo nano /etc/hosts```

```
sudo reboot
```

Audio
=====

There might be some issues with alsa or other sound-components. To avoid most problems, follow these steps below:

1. plug in all audio devices
2. restart
3. note necessary audio ids:
    - arecord -l
    - aplay -l
4. configure .asoundrc (
  adjust pcm hw for  pcm.mic and pcm.speaker)

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

```
sudo apt-get update
sudo apt-get install git build-essential python-pyaudio python-numpy python-scipy python-matplotlib
cd
mkdir dev
cd dev
git clone https://github.com/bishoph/sopare.git
cd sopare
mkdir tokens
mkdir samples
python sopare.py -u
python test/test_audio.py
```

Adjust sopare configuration:

```nano config/default.ini```

```
./sopare.py -v -t test
./sopare.py -c
./sopare.py -l
```

[Optionally] Vaporize trained data again:

```
rm dict/*.raw
./sopare.py -d "*"
```

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

Adjupi
======

First copy all files to device.
```
sudo apt install python3-pip
pip3 install -r requirements.txt
sudo nano /usr/local/lib/python3.7/dist-packages/flask_restplus/fields.py
# change werkzeug to werkzeug.utils
```

Finished! :)