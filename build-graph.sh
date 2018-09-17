#!/bin/sh
sudo docker run -it -v $(pwd)/graph:/var/otp/graphs opentripplanner/opentripplanner --build /var/otp/graphs 
