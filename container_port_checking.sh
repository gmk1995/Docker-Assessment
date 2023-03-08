#! /bin/bash

# Define the container name and ports to check
container_name="nginx-welcomepage-container"
ports=("80" "443" "22")

# Loop through the ports and check if they are open
for port in "${ports[@]}"
do
  touch port_check.log
  nc -z -w1 $(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $container_name) $port && echo "Port $port is open" >> port_check.log || echo "Port $port is closed" >> port_check.log
done
