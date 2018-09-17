# OTP in GCloud Deployment by Snowdrop

This repository contains the Dockerfile and othe configuration that enables uploading an OTP server instance to Google Container Engine with a configured.

## Requirements

You need to have both [docker](https://docs.docker.com/engine/installation/) and [gcloud](https://cloud.google.com/sdk/downloads) in your machine.

Updated data from osm can be downloaded from [Geofabrik](http://download.geofabrik.de/). Downloading PBF files instead XML files is recommending as it will speed up download and processing.

## Building the graph

For building the graph you just need to download a pbf file from Geofabrik and put it in the `graph` folder, and then run the `build-graph.sh` script.

This script uses dockers [opentripplanner/opentripplanner]() image to build the graph for the osm files that exist in the `graph` folder.

This might take longer depending on the size of the OSM source file.

## Running OTP locally

In order to run OTP locally you need to build the image and then run it.

### Build the image

For building the image you need to run this command, providing a valid image-name:

`sudo docker build -t <image-name> .`

### Running

Once the image is built, you just need to run the following command:

`sudo docker run -p 127.0.0.1:<host-port>:8080 <image-name>`

Where `<image-name>` is the name you provided for the image when you built it, and `<host-port>` is the port you would like to use to access OTP server from your browser. E.g. if you ran this command:

`sudo docker run -p 127.0.0.1:9000:8080 snw-otp`

Then you would need to point your browser to `http:\\localhost:9090` to access the OTP server.

## Deployment to GCloud

Deploying OTP to GClooud requires using the `gcloud` command:

`gcloud preview app deploy --project <gcloud-project> --version <version>`

You will need to provide the GCloud project id to which the OTP server will be deployed and version (either a new or a existing one to replace it). Notice that this being a custom VM GCloud deployment, the GCloud project used will need to have billing enabled.

By default (in the `app.yaml` file) the OTP server is configured to be deployed as a GCloud AppEngine module called `opt` and requires admin login to be accesed. This makes it possible to utilize it as a microservice forming part of a bigger project deployed in GCloud, as other projects deployed there will automatically bypass the admin login.
