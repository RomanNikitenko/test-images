## Testing logic related to determining openssl version in docker images

1. `./check-openssl-version.sh` - runs testing for list of images that defined in the `images-for-testing/default-images-list.txt` file 
2. `./check-openssl-version.sh /some/path/on/file/system/file_name.txt` - runs testing for list of images that defined in the provided file 

- the script executes `docker pull` command for images defined in the file, then it executes some commands to detect `openssl` version 
- the script skips empty lines and comments in the file 
- `report-filename.txt` file is created with results of testing, `filename` - is name of the file with images for testing, for example: `report-default-images-list.txt`

## Docker images from the https://registry.devfile.io/index

1. `./fetch-devfile-io-images.sh` - fetches images from the https://registry.devfile.io/index and creates `images-for-testing/devfile-io-images.txt` file with list of images
2. `./check-openssl-version.sh /path/on/file/system/test-images/images-for-testing/devfile-io-images.txt` - creates a report file with results of testing `openssl` version for images defined in the `images-for-testing/devfile-io-images.txt` file 

## Known problems:

| Image | Problem | Details |
|-------------|-------------|-------------|
| registry.access.redhat.com/ubi8/pause:8.9-4 | `openssl` is absent     | see [Packages section](https://catalog.redhat.com/software/containers/ubi8/pause/5f781a58055542887b1a874c?architecture=amd64&image=65cba352685c2cc95d5a0bf9&container-tabs=packages)     |
| registry.access.redhat.com/ubi8/ubi-micro:8.9-7 | `openssl` is absent     | see [Packages section](https://catalog.redhat.com/software/containers/ubi8/ubi-micro/5ff3f50a831939b08d1b832a?architecture=amd64&image=65cba18ea05d0c4248609faf&container-tabs=packages)     |
| registry.access.redhat.com/ubi9/ubi-micro:9.3-13 | `openssl` is absent     | see [Packages section](https://catalog.redhat.com/software/containers/ubi9/ubi-micro/615bdf943f6014fa45ae1b58?architecture=amd64&image=65a8f97db7e4bede96526c22&container-tabs=packages)     |
| registry.access.redhat.com/ubi9-micro:9.3-13 | `openssl` is absent     | see [Packages section](https://catalog.redhat.com/software/containers/ubi9-micro/61832b36dd607bfc82e66399?architecture=amd64&image=65a8f97db7e4bede96526c22&container-tabs=packages)     |
