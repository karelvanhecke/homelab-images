# Homelab images

## Versioning

## Major version
The major version of each variant increases when backwards incompatible changes are introduced.
This does not apply to major version 0, which should be considered experimental.

Examples:
* Debian major version upgrade (e.g. 12 -> 13)
* Major version change of primary packages in image (e.g. frr 8 -> 9)
* Changes to baseimage that could introduce incompatibility (e.g. configuration or package changes)

## Minor version
The minor version of each variant increases when backwards compatible changes are introduced.

Examples:
* Debian point release upgrade (e.g. 12.5 -> 12.6)
* Minor version change of primary packages in image (e.g. frr 8.4 -> 8.5)
* Changes to baseimage that should not introduce incompatibility (e.g. configuration or package changes)

## Patch version
The minor version of each variant increases when backwards compatible bug fix or security updates are introduced.

### Generic image versioning matrix

| Image version | Debian version |
| ------------- | -------------- |

### Router image versioning matrix

| Image version | Debian version | FRR version |
| ------------- | -------------- | ----------- |

### Nameserver image versioning matrix

| Image version | Debian version | FRR version | Bind9 version |
| ------------- | -------------- | ----------- | ------------- |
