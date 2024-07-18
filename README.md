# Mirroring official images to private dockerhub

The repository contains a script to mirror official images to private dockerhub.

## Prerequisites

Make sure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- [jq](https://stedolan.github.io/jq/download/)
- [curl](https://curl.se/download.html)

Please setup docker login credentials in `~/.docker/config.json` file.

Example:

```json
{
    "auths": {
        "https://index.docker.io/v1/": {
            "auth": "<base64-encoded-username:password>"
        }
    }
}
```

## Usage

```bash
./mirror.sh <filepath-to-images-list> <repository-name>
```

## Example

```bash
./mirror.sh images-list.txt marlapativ
```
