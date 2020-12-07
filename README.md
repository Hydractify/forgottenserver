<div>
    <p align="center">
        <a href="https://www.hydractify.org">
            <img src="https://www.hydractify.org/logo.png" height="250px" />
        </a>
    </p>
    <p align="center">
        <a href="https://www.hydractify.org/discord">
            <img src="https://img.shields.io/discord/298969150133370880.svg?style=flat-square&logo=discord">
        </a>
        <a href="https://www.hydractify.org/patreon">
            <img src="https://img.shields.io/badge/Patreon-support!-fa6956.svg?style=flat-square&logo=patreon" />
        </a>
        <a href="https://twitter.com/hydractify">
            <img src="https://img.shields.io/twitter/follow/hydractify.svg?style=social&logo=twitter">
        </a>
        <br />
        <a href="https://github.com/Hydractify/kanna_kobayashi/issues">
            <img src="https://img.shields.io/github/issues/Hydractify/forgottenserver.svg?style=flat-square">
        </a>
        <a href="https://github.com/Hydractify/kanna_kobayashi/graphs/contributors">
            <img src="https://img.shields.io/github/contributors/Hydractify/forgottenserver.svg?style=flat-square">
        </a>
        <a href="https://github.com/Hydractify/kanna_kobayashi/blob/stable/LICENSE">
            <img src="https://img.shields.io/github/license/Hydractify/forgottenserver.svg?style=flat-square">
        </a>
    </p>
</div>

# forgottenserver
Repository for maintaing our custom open tibia server using forgottenserver.

## What you need

- MySQL
- A computer

## Getting started

This server has been tested/used in [Linux], we cannot guarantee it will work in [MacOS] or [Windows], however, it might.

### Compiling

The steps to compile the server can be found here: https://github.com/otland/forgottenserver/wiki/Compiling

### MySQL

After you built `tfs`, you can proceed to work with `MySql`. You can use whatever user and database name you want, our recommendation is to have `forgottenserver`.

After you set up the user and granted permission to the database, you can run the `schema.sql` located in the root of the project. Here is a handy way to do it in [Linux]: `sudo mysql -u root -p forgottenserver < ./schema.sql`

### Configuration

Copy the `config.lua.dist` and name it `config.lua`, there you want to change the `mysqlUser` to whatever you named the MySql user, `mysqlPass` for it's password (if there is any) and change `mysqlDatabase` to whatever you named the database.

Once you are done with that, all you have to do is run the `tfs` that you compiled! Have fun. :)

### Documentation

Use this link as reference for everything related to the open tibia server:

- [forgottenserver]

You will be able to find the world and datapack we used as base in these links:

- [orts/world]
- [orts/server]

<!-- LINKS -->

<!-- MISC -->
[linux]: https://www.linux.org/
[macos]: https://www.apple.com/macos
[windows]: https://www.microsoft.com/en-us/windows

<!-- DOC -->
[forgottenserver]: https://github.com/otland/forgottenserver/wiki
[orts/world]: https://github.com/orts/world
[orts/server]: https://github.com/orts/server
