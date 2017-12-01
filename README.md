# Counter-Strike Source Dedicated Server in Docker

## Linux
[![](https://images.microbadger.com/badges/version/lacledeslan/gamesvr-cssource.svg)](https://microbadger.com/images/lacledeslan/gamesvr-cssource "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/lacledeslan/gamesvr-cssource.svg)](https://microbadger.com/images/lacledeslan/gamesvr-cssource "Get your own image badge on microbadger.com")

**Download**
```
docker pull lacledeslan/gamesvr-cssource
```

**Run Interactive Server**
```
docker run -it --rm --net=host lacledeslan/gamesvr-source ./srcds_run -game cstrike -tickrate 100 +map de_dust2 +sv_lan 1
```

**Run Self Tests**
```
docker run -it --rm lacledeslan/gamesvr-cssource ./ll-tests/gamesvr-cssource.sh
```
