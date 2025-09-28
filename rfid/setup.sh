#!/bin/bash
set -e

echo "🔧 Enabling I2C..."
sudo raspi-config nonint do_i2c 0

echo "📦 Installing required packages..."
sudo apt-get update
sudo apt-get install -y libusb-dev libpcsclite-dev i2c-tools build-essential wget

echo "⬇️ Downloading libnfc..."
cd ~
wget http://dl.bintray.com/nfc-tools/sources/libnfc-1.7.1.tar.bz2
tar -xf libnfc-1.7.1.tar.bz2
cd libnfc-1.7.1

echo "⚙️ Compiling and installing libnfc..."
./configure --prefix=/usr --sysconfdir=/etc
make
sudo make install

echo "📝 Configuring libnfc..."
sudo mkdir -p /etc/nfc
sudo tee /etc/nfc/libnfc.conf > /dev/null <<EOL
allow_autoscan = true
allow_intrusive_scan = false
log_level = 1
device.name = "_PN532_I2c"
device.connstring = "pn532_i2c:/dev/i2c-1"
EOL

echo "✅ Setup complete!"
echo "👉 Make sure PN532 hardware switch is set: SEL0=HIGH, SEL1=LOW"
