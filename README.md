## Testing logic related to determining openssl version in docker images

1. `./check-openssl-version.sh` - runs testing for list of images that defined in the `images-for-testing/default-images-list.txt` file 
2. `./check-openssl-version.sh /some/path/on/file/system/file_name.txt` - runs testing for list of images that defined in the provided file 

- the script executes `docker pull` command for images defined in the file, then it executes some commands to detect `openssl` version 
- the script skips empty lines and comments in the file 
- `report-filename.txt` file is created with results of testing, `filename` - is name of the file with images for testing, for example: `report-default-images-list.txt`
