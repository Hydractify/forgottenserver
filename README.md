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

You also want to make sure that you have decompressed the `map.rar` file that comes inside `data/world`, otherwise the server will not find a map. If you have not cloned with the `submodule` flag, you can get the map files in [orts/world].

Once you are done with that, all you have to do is run the `tfs` that you compiled! Have fun. :)

### Documentation

Use this link as reference for everything related to the open tibia server:

- [forgottenserver]

You will be able to find the world that we are using as well as the server we are basing ourselves off of in these links:

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
