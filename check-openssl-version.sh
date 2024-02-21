#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
IMAGES_LIST_SOURCE="$SCRIPT_DIR/images-for-testing/default-images-list.txt"
images_with_errors=()
counter=0

if [ $# -gt 0 ]; then
  IMAGES_LIST_SOURCE="$1"
fi

FILENAME=$(basename "$IMAGES_LIST_SOURCE")
REPORT="$SCRIPT_DIR/reports/report-$FILENAME"
#clean up the file with report
true >"$REPORT"

{
  if [ -f "$IMAGES_LIST_SOURCE" ]; then
    echo -e "******* Using the following file to read images for testing: $IMAGES_LIST_SOURCE\n******* "
  else
    echo -e "!!!!!!! File with images for testing not found: : $IMAGES_LIST_SOURCE.\n!!!!!!! Please provide path to the file with images for testing!"
    exit 1
  fi
} >>"$REPORT"

check_openssl_version() {
  echo ""
  if command -v openssl &>/dev/null; then
    echo "+++ OpenSSL command is available"
  else
    echo "--- OpenSSL command is not available"
  fi

  if command -v rpm &>/dev/null; then
    echo "+++ RPM command is available"
  else
    echo "--- RPM command is not available"
  fi

  echo ""
  if command -v openssl &>/dev/null; then
    echo "=== OpenSSL version is: $(openssl version -v)"

    openssl_major_version=$(openssl version -v | cut -d' ' -f2 | cut -d'.' -f1)
    echo "=== OpenSSL major version is: $openssl_major_version"
  elif command -v rpm &>/dev/null; then
    echo "=== OpenSSL version is: $(rpm -qa | grep openssl-libs | cut -d'-' -f3)"

    openssl_major_version=$(rpm -qa | grep openssl-libs | cut -d'-' -f3 | cut -d'.' -f1)
    echo "=== OpenSSL major version is: $openssl_major_version"
  else
    echo "ERROR: OpenSSL and rpm commands are not available"
  fi
}

export -f check_openssl_version
while IFS= read -r image; do
  if [[ -z "$image" ]] || [[ "$image" == \#* ]]; then
    continue
  fi

  docker pull "$image"
  ((counter++))

  entrypoint="sh"
  if [[ "$image" == *"docker.io/golang"* ]]; then
    entrypoint="bash"
  fi

  {
    echo "============================== $counter ====================================="
    echo "Docker image: $image"
  } >>"$REPORT"

  output="$(docker run --rm --entrypoint="$entrypoint" "$image" -c "$(declare -f check_openssl_version); check_openssl_version")"

  if [[ "$output" == *"ERROR"* ]]; then
    images_with_errors+=("$image")
  fi

  {
    echo "$output"
    echo ""
  } >>"$REPORT"
done <"$IMAGES_LIST_SOURCE"

{
  if [ ${#images_with_errors[@]} -eq 0 ]; then
    echo "------------------------------- No problems were found for the tested list of images -------------------------------------- "
    echo "--------------------------------------------------------------------------------------------------------------------------- "
  else
    echo "------------------------------- The following images contain problems ------------------------------- "
    for img in "${images_with_errors[@]}"; do
      echo "$img"
    done
    echo "----------------------------------------------------------------------------------------------------- "
  fi

} >>"$REPORT"
