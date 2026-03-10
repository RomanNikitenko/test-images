# Test Images for Dev Spaces 3.27

## URL pattern used for testing images

`https://<che_fqdn>/#<url_to_a_sample_project>?new&image=<ubi10_based_image_for_testing>&editor-image=<url_to_the_editor_image>`

References:
- https://eclipse.dev/che/docs/stable/end-user-guide/url-parameter-for-container-image/
- https://eclipse.dev/che/docs/stable/end-user-guide/url-parameter-for-the-ide-image/

Example:
- https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi10-minimal:10.0-1752576249&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f

## Workspace startup matrix

### UDI

| Image | Workspace starts | Link to start workspace |
| --- | --- | --- |
| `quay.io/devfile/universal-developer-image:latest` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=quay.io/devfile/universal-developer-image:latest&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `quay.io/devfile/universal-developer-image:ubi8-latest` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=quay.io/devfile/universal-developer-image:ubi8-latest&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `quay.io/devfile/universal-developer-image:ubi9-latest` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=quay.io/devfile/universal-developer-image:ubi9-latest&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `quay.io/devfile/universal-developer-image:ubi10-latest` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=quay.io/devfile/universal-developer-image:ubi10-latest&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |

### UBI 8

| Image | Workspace starts | Link to start workspace |
| --- | --- | --- |
| `registry.access.redhat.com/ubi8:latest` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi8:latest&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi8:8.10` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi8:8.10&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi8:8.9` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi8:8.9&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi8-minimal:latest` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi8-minimal:latest&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi8-minimal:8.10` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi8-minimal:8.10&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi8-minimal:8.9` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi8-minimal:8.9&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |

### UBI 9

| Image | Workspace starts | Link to start workspace |
| --- | --- | --- |
| `registry.access.redhat.com/ubi9:latest` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi9:latest&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi9:9.7` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi9:9.7&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi9:9.6` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi9:9.6&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi9-minimal:latest` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi9-minimal:latest&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi9-minimal:9.7` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi9-minimal:9.7&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi9-minimal:9.6` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi9-minimal:9.6&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |

### UBI 10

| Image | Workspace starts | Link to start workspace |
| --- | --- | --- |
| `registry.access.redhat.com/ubi10:latest` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi10:latest&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi10:10.1` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi10:10.1&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi10:10.0` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi10:10.0&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi10-minimal:latest` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi10-minimal:latest&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi10-minimal:10.1` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi10-minimal:10.1&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
| `registry.access.redhat.com/ubi10-minimal:10.0` | 🟢 | [click here](https://che-dogfooding.apps.che-dev.x6e0.p1.openshiftapps.com/#https://github.com/RomanNikitenko/web-nodejs-sample?new&image=registry.access.redhat.com/ubi10-minimal:10.0&editor-image=quay.io/redhat-user-workloads/devspaces-tenant/devspaces/code-rhel9:on-pr-26ba1b35b0666a923b7d3d5d5a37988a9890158f) |
