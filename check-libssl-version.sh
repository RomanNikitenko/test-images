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
REPORT="$SCRIPT_DIR/reports/libssl/report-$FILENAME"
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

########################################## TARGET FUNCTION ##########################################
libssl_version=""
get_libssl_version() {
  libssl=$(find / -type f \( -name "libssl.so*" \) 2>/dev/null)
  if [ -z "$libssl" ]; then
    for dir in /lib64 /usr/lib64 /lib /usr/lib /usr/local/lib64 /usr/local/lib; do
      for file in "$dir"/libssl.so*; do
        if [ -e "$file" ]; then
          libssl="$file"
          break 2
        fi
      done
    done
  fi

  echo ">>> libssl               $libssl"

  case "${libssl}" in
  *libssl.so.1*)
    echo ">>> libssl version       1"
    libssl_version="1"
    ;;
  *libssl.so.3*)
    echo ">>> libssl version       3"
    libssl_version="3"
    ;;
  *)
    libssl_version=""
    echo ">>> ERROR:               Can not detect libssl version"
    ;;
  esac
}
########################################## ^ TARGET FUNCTION ^ ##########################################

export -f get_libssl_version
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
    echo ""
    echo "=== DOCKER IMAGE:        $image"
  } >>"$REPORT"

  output="$(docker run --rm --entrypoint="$entrypoint" "$image" -c "$(declare -f get_libssl_version); get_libssl_version")"

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
