# Counter-Strike: Source Dedicated Server in Docker

Counter-Strike: Source is a remake of Counter-Strike using the Source game engine. As in the original, Counter-Strike: Source pits a team of counter-terrorists against a team of terrorists in a series of rounds. Each round is won either by completing an objective (such as detonating a bomb or rescuing hostages) or by eliminating all members of the enemy team.

![Counter-Strike: Source Screenshot](https://raw.githubusercontent.com/LacledesLAN/gamesvr-cssource/master/.misc/screenshot1.jpg "Counter-Strike: Source Screenshot")

This repository is maintained by [Laclede's LAN](https://lacledeslan.com). Its contents are intended to be bare-bones and used as a stock server. For examples of building a customized server from this Docker image browse its related child-project [gamesvr-cssource-freeplay](https://github.com/LacledesLAN/gamesvr-cssource-freeplay). If any documentation is unclear or it has any issues please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## Linux

[![linux/amd64](https://github.com/LacledesLAN/gamesvr-cssource/actions/workflows/build-linux-image.yml/badge.svg?branch=master)](https://github.com/LacledesLAN/gamesvr-cssource/actions/workflows/build-linux-image.yml)

### Download

```shell
docker pull lacledeslan/gamesvr-cssource
```

### Run Self Tests

The image includes a test script that can be used to verify its contents. No changes or pull-requests will be accepted to this repository if any tests fail.

```shell
docker run -it --rm lacledeslan/gamesvr-cssource ./ll-tests/gamesvr-cssource.sh
```

### Run Simple, Interactive Server

```shell
docker run -it --rm --net=host lacledeslan/gamesvr-cssource ./srcds_run -game cstrike -tickrate 100 +map de_dust2 +sv_lan 1
```

## Getting Started with Game Servers in Docker

[Docker](https://docs.docker.com/) is an open-source project that bundles applications into lightweight, portable, self-sufficient containers. For a crash course on running Dockerized game servers check out [Using Docker for Game Servers](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/DockerAndGameServers.md). For tips, tricks, and recommended tools for working with Laclede's LAN Dockerized game server repos see the guide for [Working with our Game Server Repos](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/WorkingWithOurRepos.md). You can also browse all of our other Dockerized game servers: [Laclede's LAN Game Servers Directory](https://github.com/LacledesLAN/README.1ST/tree/master/GameServers).
