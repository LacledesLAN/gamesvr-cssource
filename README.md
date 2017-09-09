# Counter-Strike Source Server in Docker

## Linux
[![](https://images.microbadger.com/badges/version/lacledeslan/gamesvr-cssource.svg)](https://microbadger.com/images/lacledeslan/gamesvr-cssource "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/lacledeslan/gamesvr-cssource.svg)](https://microbadger.com/images/lacledeslan/gamesvr-cssource "Get your own image badge on microbadger.com")

**Download**
```
docker pull lacledeslan/gamesvr-cssource
```

**Run self tests**
```
NOT YET IMPLEMENTED
```

**Run simple interactive server**
```
docker run -it --rm --net=host lacledeslan/gamesvr-source ./srcds_run -game cstrike -tickrate 100 +map de_dust2 -console -usercon +sv_lan 1
```

## Build Triggers
Automated builds of this image can be triggered by the following sources:
* [Builds of llgameserverbot/cssource-watcher](https://hub.docker.com/r/llgameserverbot/cssource-watcher/)
* [Commits to GitHub repository](https://github.com/LacledesLAN/gamesvr-cssource)
