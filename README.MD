# atom-http
This is an X application accessible in a browser window.

Docker service to share [atom](https://atom.io/) over http. Useful for demos or syncing up with co-workers.

```
docker run \
  -p 8080:8080 \
  -v $PWD:/workspace \ # path to a workspace
  justmiles/atom-http:latest
```

## Optional Configs
### Volumes
- `/workspace` - The workspace atom opens
- `/.atom` - Atom configs (~/.atom)

### Environment Variables
- `APM_PACKAGE=''` - Space delimited list of atom packages to install
- `USER_ID=1000` - User to run atom as
- `GROUP_ID=1000` - Group to run atom as
- `APP_NAME=atom` - Application name that is passed to Guacamole
- `WIDTH=1920`    - Width of the X server window
- `HEIGHT=960`    - Height of the X server window

## Quick and easy function
To use this, execute `atom-http <path to workspace>`
```
function atom-http {
  workspace=${1:-"$PWD"}
  port=${2:-"8081"}
  docker rm -f atom-http || true
  docker run -d --rm \
    -p $port:8080 \
    -v $HOME/.atom:/.atom \
    -v $(realpath $workspace):/workspace \
    --name atom-http \
    -e WIDTH=1920 \
    -e HEIGHT=960 \
    justmiles/atom-http:latest
  sleep 2 && xdg-open http://0.0.0.0:$port &
}
```