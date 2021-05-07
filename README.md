## Pulling the image

```bash
docker pull ghcr.io/techcentr/nodejs-devenv
```

## Available tags

- `ghcr.io/techcentr/nodejs-devenv` - based on NodeJS v14 alpine image

## Installed software
The image contains other required software. For full list, check the [Dockerfile](./Dockerfile).

## Entrypoint
Unlike the default NodeJS image, the entrypoint has been changed to the default shell (ash).