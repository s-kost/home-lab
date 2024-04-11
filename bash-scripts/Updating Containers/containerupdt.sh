#!/bin/bash

USER="<your user name>" # Define the user that owns the containers

NUM_CONTAINERS=$(sudo docker ps -q | wc -l) # Return the number of containers
CONTAINERS=$(sudo docker ps | awk '{print $1}' | tail -n $NUM_CONTAINERS) # Retrives the container IDs
CONTAINER_DIRS=$(sudo find /home/$USER/containers -mindepth 1 -maxdepth 1 -type d) # Retrives the directories with docker-compose.yaml file for each container (Container data is also stored in those directories)
CNT_ARRAY=() # Creates empty array for the container IDs
DIR_ARRAY=() # Creates empty array for the container directories

# Splits the $CONTAINERS string and adds every container ID to $CNT_ARRAY
for ((i=1; i <= $NUM_CONTAINERS; i++)); do
  CNT_ARRAY+=("$(echo $CONTAINERS | cut -d ' ' -f$i)")
done

# Goes through $CNT_ARRAY, gets the container ID and uses it to stop and delete the container with the coresponding ID
for i in "${CNT_ARRAY[@]}"; do
  echo "Stoping Container with ID: $i"
  sudo docker stop $i > /dev/null
  echo "Deleteing Container with ID: $i"
  sudo docker rm $i > /dev/null
done

# Splits the $CONTAINER_DIRS string and add every container directory to $DIR_ARRAY
for (( i=1; i <= $NUM_CONTAINERS; i++ )); do
  DIR_ARRAY+=("$(echo $CONTAINER_DIRS | cut -d ' ' -f$i)")
done

# Uses every directory from DIR_ARRAY to launch every docker-compose.yaml file
for i in "${DIR_ARRAY[@]}"; do
  echo $i
  sudo docker compose --project-directory $i up -d
done

# Removes every unused docker image
sudo docker image prune -af