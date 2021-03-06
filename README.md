docker-direwolf20
=================

Dockerfile for direwolf20

This docker image provides a Minecraft Server, based on the direwolf20 FTB mod pack, that will automatically download the latest stable or any specific version.

To simply use the latest stable version, run:

    docker run -d -p 25565:25565 bortels/direwolf20

where the default server port, 25565, will be exposed on your host machine. If you want to serve up multiple Minecraft servers or just use an alternate port, change the host-side port mapping such as:

    docker run -p 25566:25565 ...

will service port 25566.

Speaking of multiple servers, it's handy to give your containers explicit names using `--name`, such as

    docker run -d -p 25565:25565 --name minecraft bortels/direwolf20

With that you can easily view the logs, stop, or re-start the container:

    docker logs -f minecraft
        ( Ctrl-C to exit logs action )

    docker stop minecraft

    docker start minecraft


## Attaching data directory to host filesystem

In order to persist the Minecraft data, which you *probably want to do for a real server setup*, use the `-v` argument to map a directory of the host to ``/data``:

    docker run -d -v /path/on/host:/data -p 25565:25565 bortels/direwolf20

When attached in this way you can stop the server, edit the configuration under your attached ``/path/on/host`` and start the server again with `docker start CONTAINERID` to pick up the new configuration.


## Versions

To use a different Minecraft version, pass the `VERSION` environment variable, which can have the value

* LATEST
* (or a specific version, such as "1.1.19")

For example, to use the latest version:

    docker run -d -e VERSION=LATEST ...

or a specific version:

    docker run -d -e VERSION=1.1.19 ...


## Server configuration

The message of the day, shown below each server entry in the UI, can be changed with the `MOTD` environment variable, such as:

    docker run -d -e 'MOTD=My Server' ...

If you leave it off, the last used or default message will be used.

To add more "op" (aka adminstrator) users to your Minecraft server, pass the Minecraft usernames separated by commas via the `OPS` environment variable, such as:

    docker run -d -e OPS=user1,user2 ...

The Java memory limit can be adjusted using the `JVM_OPTS` environment variable, where the default is the setting shown in the example (max and min at 2048 MB):

    docker run -e 'JVM_OPTS=-Xmx2048M -Xms2048M' ...

## Credits

Thank you Notch - Minecraft is teh awesome.

Feed the Beast Crew - w00t on your bad selves. 

This repository is largley swiped from https://github.com/rafaelmartins/docker-ftblite2 - Thank you for sharing! 

Docker - totally revolutionary. I stand in awe, no lie.

Finally - w00t on the github crew, Linus and all of the linux brethern, Admiral Grace Hopper, Ada Lovelace, and everyone else involved in computing. You are the wind beneath my container. 

ooh - and direwolf20. Love your spotlights, let's play, watch him on youtube! 
