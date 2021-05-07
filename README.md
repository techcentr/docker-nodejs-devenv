## Pulling the image

```
docker pull ...tba...
```

## Available tags

- `nodejs-devenv:<version>-node14-alpine` - based on NodeJS v14 alpine image

## Installed software
The image contains other required software. For full list, check the [Dockerfile](./Dockerfile).

## Entrypoint
Unlike the default NodeJS image, the entrypoint has been changed to the default shell (ash).