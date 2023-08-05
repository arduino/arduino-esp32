#!/usr/bin/env bash

arduino_mbed_rules () {
    echo ""
    echo "# Arduino ESP32 bootloader mode udev rules"
    echo ""
cat <<EOF
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0070", MODE:="0666"
EOF
}

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

arduino_mbed_rules > /etc/udev/rules.d/60-arduino-esp32.rules

# reload udev rules
echo "Reload rules..."
udevadm trigger
udevadm control --reload-rules