#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
IMAGES_LIST_SOURCE="$SCRIPT_DIR/images-for-testing/default-images-list.txt"

#for the following images bash should be used as entrypoint
bash_images=("docker.io/golang" "docker.io/ubuntu:22.04")

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
    echo "************** Using the following file to read images for testing: $IMAGES_LIST_SOURCE"
    echo ""
  else
    echo -e "!!!!!!! File with images for testing not found: : $IMAGES_LIST_SOURCE.\n!!!!!!! Please provide path to the file with images for testing!"
    exit 1
  fi
} >>"$REPORT"

check_openssl_version() {
  echo ""
  ################# OpenSSL command #################
  if command -v openssl &>/dev/null; then
    echo "+++ OpenSSL command is available:           $(openssl version -v)"
  else
    echo "--- OpenSSL command is not available"
  fi

  ################# RPM command #################
  if command -v rpm &>/dev/null; then
    echo "+++ RPM command     is available:           $(rpm -qa | grep openssl-libs | cut -d'-' -f3)"
  else
    echo "--- RPM command     is not available"
  fi

  ################# Libs #################
  libssl=$(find / -type f \( -name "libssl.so*" \) 2>/dev/null)
  if [ -n "$libssl" ]; then
    echo "+++ libssl          is found:               $libssl [find]"
  else
    for dir in /lib64 /usr/lib64 /lib /usr/lib /usr/local/lib64 /usr/local/lib; do
      for file in "$dir"/libssl.so*; do
        if [ -e "$file" ]; then
          libssl="$file"
          echo "+++ libssl    is found:                     $libssl [libs]"
          break 2
        fi
      done
    done
  fi

  if [ -z "$libssl" ]; then
    echo "--- libssl          is not found"
  fi

  ################# Major version for all ways #################
  echo ""
  if command -v openssl &>/dev/null; then
    openssl_major_version=$(openssl version -v | cut -d' ' -f2 | cut -d'.' -f1)
    echo "=== [openssl] ==================  $openssl_major_version"
  else
    echo "=== [openssl] ==================  -"
  fi

  if command -v rpm &>/dev/null; then
    openssl_major_version=$(rpm -qa | grep openssl-libs | cut -d'-' -f3 | cut -d'.' -f1)
    echo "=== [rpm]     ==================  $openssl_major_version"
  else
    echo "=== [rpm]     ==================  -"
  fi

  if [ -z "$libssl" ]; then
    echo "=== [libs]    ==================  -"
  elif [[ "${libssl}" == *"libssl.so.1"* ]]; then
    echo "=== [libs]    ==================  1"
  elif [[ "${libssl}" == *"libssl.so.3"* ]]; then
    echo "=== [libs]    ==================  3"
  else
    echo "=== [libs]    ==================  -"
  fi

  echo ""
  openssl_major_version=""
  detection_way=""
  
  if command -v openssl &>/dev/null; then
    openssl_major_version=$(openssl version -v | cut -d' ' -f2 | cut -d'.' -f1)
    detection_way="opennsl command way"
  elif command -v rpm &>/dev/null; then
    openssl_major_version=$(rpm -qa | grep openssl-libs | cut -d'-' -f3 | cut -d'.' -f1)
    detection_way="rpm way"
  elif [[ "${libssl}" == *"libssl.so.1"* ]]; then
    openssl_major_version="1"
    detection_way="libs way"
  elif [[ "${libssl}" == *"libssl.so.3"* ]]; then
    openssl_major_version="3"
    detection_way="libs way"
  fi

  if [ -n "$openssl_major_version" ]; then
    echo -e ">>> OpenSSL major version ======  $openssl_major_version         [$detection_way]"
  else
    echo ">>> ERROR: Can not detect OpenSSL version"
  fi
}

export -f check_openssl_version
while IFS= read -r image; do
  # skip empty lines and comments
  if [[ -z "$image" ]] || [[ "$image" == \#* ]]; then
    continue
  fi

  docker pull "$image"
  ((counter++))

  entrypoint="sh"
  for bash_image in "${bash_images[@]}"; do
    if [[ "$image" == *"$bash_image"* ]]; then
      entrypoint="bash"
      break
    fi
  done

  {
    echo "========================================================================================================= [$counter] "
    echo "********************** DOCKER IMAGE:        $image"
  } >>"$REPORT"

  output="$(docker run --rm --entrypoint="$entrypoint" "$image" -c "$(declare -f check_openssl_version); check_openssl_version")"

  if [[ -z "$output" ]] || [[ "$output" == *"ERROR"* ]]; then
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
