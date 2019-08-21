#!/bin/sh

echo "Initializing Bluetooth hardware"
/usr/bin/hciattach /dev/ttyAMA0 bcm43xx 921600 noflow -

echo "Starting Bluetooth demon"
/usr/libexec/bluetooth/bluetoothd &

echo "Enabling Bluetooth"
/usr/bin/bluetoothctl <<EOF
power on
discoverable on
exit
EOF

echo "Configuring HCI"
/usr/bin/hciconfig hci0 piscan
/usr/bin/hciconfig hci0 sspmode 1
/usr/bin/hciconfig hci0 name 'HiFiBerry'

echo "Bluetooth devices"
/usr/bin/hcitool dev

echo "Starting A2DP agent"
/root/a2dp-agent.py &
sleep 2

echo "Starting BlueALSA Sink"
/usr/bin/bluealsa -i hci0 -p a2dp-sink &
sleep 2

echo "Starting BlueALSA aplay"
/usr/bin/bluealsa-aplay --pcm-buffer-time=250000 00:00:00:00:00:00 &


