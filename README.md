## Testing logic related to determining openssl version in docker images

1. `./check-openssl-version.sh` - runs testing for list of images that defined in the `images_list.txt` file 
2. `./check-openssl-version.sh /some/path/on/file/system/file_name.txt` - runs testing for list of images that defined in the provided file 

- the script pulls images from the file and executes some commands to detect `openssl` version 
- the script skips empty lines and comments in the file 
- report.txt file is created with results of testing
