# This repo is a fork of [morgyn's starbound server docker](https://github.com/Morgyn/docker-starbound) adapted to include the [FrackinUniverse mod](https://github.com/sayterdarkwynd/FrackinUniverse).

This is a docker image of the dedicated server for Stardbound with the [FrackinUniverse mod](https://github.com/sayterdarkwynd/FrackinUniverse).

* [ http://playstarbound.com/ ]
* [ http://store.steampowered.com/app/211820/ ]
* [ https://github.com/sayterdarkwynd/FrackinUniverse ]

The difference between this docker image and others, is that you do not need to store your steam username, password and either disable steamguard or save a steamguard key. The downside is you need to manually update when needed.

## Docker compose
```yml
name: FrackinUniverse_Server
services:
    frackin-universe-docker:
        container_name: frackinuniverse
        ports:
            - 21025:21025
        volumes:
            - starbound:/starbound
        image: ghcr.io/cfazilleau/frackin-universe-docker
volumes:
    starbound:
        external: true
        name: starbound
```

or

## Get the image
```sh
docker pull ghcr.io/cfazilleau/frackin-universe-docker:main
```

## Run the image
```sh
docker run --name frackinuniverse -p 21025:21025 -v <starbound directory>:/starbound ghcr.io/cfazilleau/frackin-universe-docker
```

Replace `<starbound directory>` with where you wish to store your Starbound installation.

The image contains nothing but the update script and the steamcmd. You will have to first run update.sh to download the game and mod

## Run the update script while the image is running
```sh
docker exec -t -i frackinuniverse /update.sh <steam_login_id> [frackin_universe_version (defaults to latest)]
```

This script will prompt you to for your password (and steamguard if it's required), it will then perform the initial installation.

If it fails or quits for some reason, you can just rerun to complete.

After the installation has completed successfully, the container will stop


## Configure your Starbound server.

Edit your configuration in the installation directory you chose (``.../starbound/storage/starbound_server.config``)

[ http://starbounder.org/Guide:Setting_Up_Multiplayer#Advanced_Server_Configuration ]

## Restart the docker image to start the server
```sh
docker run frackinuniverse
```

## Updating.

With the server still running, run the update script as above. It will quit the server, then begin the update. Like the initial installation, if the update fails or quits for some reason, just run again, it will stop the container when it is successful.

To run with the update, just start the docker image again as above.
