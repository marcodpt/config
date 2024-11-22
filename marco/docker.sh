# List all images
docker images

# List all process
docker ps -a

# Create a process from a image
docker run --name php -p 8080:80 -v .:/data/php -it ubuntu:24.04 /bin/bash

# commit container
docker commit php

#reconnet
docker restart php
docker attach php

# Remove image
docker rmi [image]
