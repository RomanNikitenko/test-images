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
REPORT="$SCRIPT_DIR/reports/openssl/report-$FILENAME"
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
  libssl_version=""
  libssl=""
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

    if [ -n "$libssl" ]; then
      echo "+++ libssl          is found:               $libssl [libs]"
    else
      echo "--- libssl          is not found"
    fi

    case "${libssl}" in
    *libssl.so.1*)
      libssl_version="1"
      ;;
    *libssl.so.3*)
      echo "[INFO] libssl version is: 3"
      libssl_version="3"
      ;;
    *)
      libssl_version=""
      echo "[WARNING] unknown libssl version: $libssl"
      ;;
    esac
  }

  openssl_version=""
  detection_way=""
  get_openssl_version() {
    if command -v openssl >/dev/null 2>&1; then
      echo "+++ OpenSSL command is available:           $(openssl version -v)"
    else
      echo "--- OpenSSL command is not available"
    fi

    if command -v rpm >/dev/null 2>&1; then
      rpm_version=$(rpm -q --qf '%{VERSION}\n' openssl-libs 2>/dev/null)
      if [ -n "$rpm_version" ]; then
        echo "+++ RPM command     is available:           $rpm_version"
      else
        echo "--- RPM command     is available but openssl-libs not found"
      fi
    else
      echo "--- RPM command     is not available"
    fi

    # Always probe libssl so the report includes [libs] diagnostics for every image.
    get_libssl_version

    if command -v openssl >/dev/null 2>&1; then
      openssl_version=$(openssl version -v | cut -d' ' -f2 | cut -d'.' -f1)
      if [ -n "$openssl_version" ]; then
        detection_way="openssl command way"
      fi
    elif command -v rpm >/dev/null 2>&1; then
      openssl_version=$(rpm -q --qf '%{VERSION}\n' openssl-libs 2>/dev/null | cut -d'.' -f1)
      if [ -n "$openssl_version" ]; then
        detection_way="rpm way"
      fi
    else
      echo "[INFO] openssl and rpm commands are not available, trying to detect OpenSSL version..."
      openssl_version=$libssl_version
      if [ -n "$openssl_version" ]; then
        detection_way="libs way"
      fi
    fi
  }

  echo ""
  get_openssl_version

  echo ""
  if command -v openssl >/dev/null 2>&1; then
    openssl_major_version=$(openssl version -v | cut -d' ' -f2 | cut -d'.' -f1)
    echo "=== [openssl] ==================  $openssl_major_version"
  else
    echo "=== [openssl] ==================  -"
  fi

  if command -v rpm >/dev/null 2>&1; then
    openssl_major_version=$(rpm -q --qf '%{VERSION}\n' openssl-libs 2>/dev/null | cut -d'.' -f1)
    if [ -n "$openssl_major_version" ]; then
      echo "=== [rpm]     ==================  $openssl_major_version"
    else
      echo "=== [rpm]     ==================  -"
    fi
  else
    echo "=== [rpm]     ==================  -"
  fi

  case "${libssl}" in
  *libssl.so.1*)
    echo "=== [libs]    ==================  1"
    ;;
  *libssl.so.3*)
    echo "=== [libs]    ==================  3"
    ;;
  *)
    echo "=== [libs]    ==================  -"
    ;;
  esac

  if [ -n "$openssl_version" ]; then
    echo ">>> OpenSSL major version ======  $openssl_version         [$detection_way]"
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

  podman pull "$image"
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
    echo "********************** PODMAN IMAGE:        $image"
  } >>"$REPORT"

  output="$(podman run --rm --entrypoint="$entrypoint" "$image" -c "$(declare -f check_openssl_version); check_openssl_version")"

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
