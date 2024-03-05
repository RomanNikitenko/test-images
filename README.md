## Testing logic related to determining openssl version in docker images

1. `./check-openssl-version.sh` - runs testing for list of images that defined in the `images-for-testing/default-images-list.txt` file 
2. `./check-openssl-version.sh /some/path/on/file/system/file_name.txt` - runs testing for list of images that defined in the provided file 

- the script executes `docker pull` command for images defined in the file, then it executes some commands to detect `openssl` version 
- the script skips empty lines and comments in the file 
- `reports/openssl/report-filename.txt` file is created with results of testing, `filename` - is name of the file with images for testing, for example: `report-default-images-list.txt`

## Testing logic related to determining libssl version in docker images
The functionality is similar to the previous section, so:
1. `./check-libssl-version.sh` - runs testing for list of images that defined in the `images-for-testing/default-images-list.txt` file 
2. `./check-libssl-version.sh /some/path/on/file/system/file_name.txt` - runs testing for list of images that defined in the provided file 
- `reports/libssl/report-filename.txt` file is created with results of testing, `filename` - is name of the file with images for testing, for example: `report-default-images-list.txt`

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

# Test devfiles:
- The following pattern is used for testing devfiles:
`https://<che_fqdn>/#<url_to_a_raw_devfile>&che-editor=<url_to_a_raw_yaml_file>`. 
- For example: https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/dotnet50/1.0.3&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt

#
| Image | Devfile registry link | Workspace starts | Link to start a workspace |
| :-------------: | :-------------: | :-------------: | :-------------: |
| registry.access.redhat.com/ubi8/dotnet-50:5.0-39 | [.NET 5.0](https://registry.devfile.io/viewer/devfiles/community/dotnet50) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/dotnet50/1.0.3&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/dotnet-60:6.0-45 | [.NET 6.0](https://registry.devfile.io/viewer/devfiles/community/dotnet60) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/dotnet60/1.0.2&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/dotnet-31:3.1-61 | [.NET Core 3.1](https://registry.devfile.io/viewer/devfiles/community/dotnetcore31) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/dotnetcore31/1.0.3&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/dotnet-60:6.0 | [Basic .NET](https://registry.devfile.io/viewer/devfiles/community/dotnet-basic) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/dotnet-basic&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/nodejs-16:1-153 | [Angular](https://registry.devfile.io/viewer/devfiles/community/nodejs-angular) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/nodejs-angular/2.0.2&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi9/go-toolset:1.19.13-4.1697647145 | [Basic Go](https://registry.devfile.io/viewer/devfiles/community/go-basic) | + <br /> project was not cloned | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/go-basic&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/nodejs-16:latest | [Basic Node.js](https://registry.devfile.io/viewer/devfiles/community/nodejs-basic) | + <br /> project was not cloned | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/nodejs-basic&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi9/python-39:1-165 | [Basic Python](https://registry.devfile.io/viewer/devfiles/community/python-basic) | + <br /> project was not cloned | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/python-basic&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/openjdk-17:1.18-2 | [Basic Quarkus](https://registry.devfile.io/viewer/devfiles/community/code-with-quarkus) | - <br /> Detected unrecoverable event FailedPostStartHook: PostStartHook failed. | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/code-with-quarkus&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi9/openjdk-17:1.17-1.1705573248 | [Basic Spring Boot](https://registry.devfile.io/viewer/devfiles/community/java-springboot-basic) | + <br /> project was not cloned | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-springboot-basic&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi9/python-39:1-165 | [Django](https://registry.devfile.io/viewer/devfiles/community/python-django) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/python-django/2.1.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi9/go-toolset:1.19.13-4.1697647145 | [Go Runtime](https://registry.devfile.io/viewer/devfiles/community/go) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/go/1.2.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| quay.io/devfile/composer:2.5.8 | [Laravel](https://registry.devfile.io/viewer/devfiles/community/php-laravel) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/php-laravel/1.0.1&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi9/openjdk-17:1.17-1.1705573248 | [Maven Java](https://registry.devfile.io/viewer/devfiles/community/java-maven) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-maven/1.3.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/nodejs-16:1-153 | [Next.js](https://registry.devfile.io/viewer/devfiles/community/nodejs-nextjs) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/nodejs-nextjs/1.0.3&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/nodejs-16:latest | [Node.js Runtime](https://registry.devfile.io/viewer/devfiles/community/nodejs) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/nodejs/2.1.1&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/nodejs-16:1-153 | [Nuxt.js](https://registry.devfile.io/viewer/devfiles/community/nodejs-nuxtjs) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/nodejs-nuxtjs/1.0.3&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| icr.io/appcafe/open-liberty-devfile-stack:22.0.0.1-gradle | [Open Liberty Gradle](https://registry.devfile.io/viewer/devfiles/community/java-openliberty-gradle) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-openliberty-gradle/0.4.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| icr.io/appcafe/open-liberty-devfile-stack:22.0.0.1 | [Open Liberty Maven](https://registry.devfile.io/viewer/devfiles/community/java-openliberty) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-openliberty/0.9.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi9/python-39:1-165 | [Python](https://registry.devfile.io/viewer/devfiles/community/python) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/python/2.1.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/openjdk-17:1.18-2 | [Quarkus Java](https://registry.devfile.io/viewer/devfiles/community/java-quarkus) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-quarkus/1.3.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/nodejs-16:1-153 | [React](https://registry.devfile.io/viewer/devfiles/community/nodejs-react) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/nodejs-react/2.0.2&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi9/openjdk-17:1.17-1.1705573248 | [Spring Boot](https://registry.devfile.io/viewer/devfiles/community/java-springboot) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-springboot/1.3.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/nodejs-16:1-153 | [Svelte](https://registry.devfile.io/viewer/devfiles/community/nodejs-svelte) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/nodejs-svelte/1.0.3&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| quay.io/devfile/universal-developer-image:ubi8-latest | [Universal Developer Image](https://registry.devfile.io/viewer/devfiles/community/udi) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/udi/1.0.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/openjdk-11:1.18-2.1705602259 | [Vert.x Java](https://registry.devfile.io/viewer/devfiles/community/java-vertx) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-vertx/1.3.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/nodejs-16:1-153 | [Vue](https://registry.devfile.io/viewer/devfiles/community/nodejs-vue) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/nodejs-vue/1.0.2&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| icr.io/appcafe/websphere-liberty-devfile-stack:22.0.0.1-gradle | [WebSphere Liberty Gradle](https://registry.devfile.io/viewer/devfiles/community/java-websphereliberty-gradle) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-websphereliberty-gradle/0.4.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| icr.io/appcafe/websphere-liberty-devfile-stack:22.0.0.1 | [WebSphere Liberty Maven](https://registry.devfile.io/viewer/devfiles/community/java-websphereliberty) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-websphereliberty/0.9.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| quay.io/devfile/universal-developer-image:ubi8-latest | [WildFly](https://registry.devfile.io/viewer/devfiles/community/java-wildfly) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-wildfly/2.0.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |
| registry.access.redhat.com/ubi8/openjdk-11:1.18-2.1705602259 | [WildFly Bootable Jar](https://registry.devfile.io/viewer/devfiles/community/java-wildfly-bootable-jar) | + | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://registry.devfile.io/devfiles/java-wildfly-bootable-jar/1.2.0&che-editor=https://gist.githubusercontent.com/RomanNikitenko/29845aab2a2d70dddd93b63d74910fca/raw/cf5024ad088a90fa0d536c1b152ef629fa062c9f/gistfile1.txt) |

