# flux-docker

This project contains the scripts to build a docker image based on the Flux product. It does not include the Flux software, that must be provided by the user. To get an evaluation copy, go to http://flux.ly.

## To build a local docker image

Download or copy into the `build` folder the Flux zip file. If you are using
a downloaded copy, it should be named `flux-<version>.zip`. Edit the build.sh file and set the environment variable `FLUX_VERSION` equal to the `<version>` value in the zip file name.

Execute the `./build.sh` file to build the local docker image. You can use `docker image ls | grep flux` to see the newly built image. It will have two tags, `latest` and `<version>`.

## Run the Flux system

Change to the `local` folder. Run the `./compose_run.sh` script. This will do the following:

1. Start a postgresql database server, 
2. Initialize the Flux tables
3. Start a Flux engine
4. Start a Flux console

The logs will display to stdout and you can see `flux_console_1` and `flux_engine_1` start up. Once the startup messages are complete, you can open a browser to http://localhost:7186 to see the Flux console.

## Options when running the system

You can run multiple Flux engines when the system is started. The host names for the engines must be put into the `local/config/opsconsole8.properties` file. Each engine's host name is of the following format `local_flux-engine_n` where `n` is the engine number starting from '1'. This repository delivers this file with 3 engine definitions, so you can run 1-3 engines without any changes.

To run multiple engines, preceed the `./compose_run.sh` command with an environment value of `ENGINES`. For example, the following will start 3 engines:

`ENGINES=3 ./compose_run.sh`

You can also detach the running engines to free up the console, but it is nice to not do this so you can easily see the stdout messages. If you want to detach, simply add `RUN_DETACHED=1` on the command line as follows:

`ENGINES=3 RUN_DETACHED=1 ./compose_run.sh`

If you detach and still want to see the log messages, you can run:

`docker-compose logs`

and the log messages will be displayed.

## Stopping the system

To stop, simply type `docker-compose stop`. To start back up, run the `./compose_run.sh` script with number of engines specified again.

## Cleaning out and starting all over

To delete all the containers (and stop them if they are still running) type the following:

`docker-compose down` 

This will not delete the database data and it will still be there when you restart. If you want to clean out the database data to completely restart, type the following command (while the system is stopped, of course:

`rm -fr pgdata/*`

Then the next time the system is started it will recreate empty database tables.





