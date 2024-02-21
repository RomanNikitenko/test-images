#!/bin/bash
images=()
image_file="$(dirname "$0")/images-for-testing/devfile-io-images.txt"
true >"$image_file"

devfiles=()
while IFS= read -r line; do
  devfiles+=("$line")
done < <(curl -s https://registry.devfile.io/index | jq -r '.[].links.self' | sed "s/devfile-catalog/devfiles/" | sed "s|:|/|")

for devfile in "${devfiles[@]}"; do
  image=$(curl -sSL "https://registry.devfile.io/${devfile}" | yq e '.components[0].container.image' - | sed "s/{{liberty-version}}/22.0.0.1/g")
  images+=("$image")
  echo "$image" >>"$image_file"
done
