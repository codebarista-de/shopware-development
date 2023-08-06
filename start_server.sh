#!/bin/bash

# Start docker-compose in the background
docker-compose up &

# Save the PID of the docker-compose process
DOCKER_PID=$!

# Start symfony server in the background
symfony server:start &

# Save the PID of the Symfony process
SYMFONY_PID=$!

# Function to stop processes
function stop_processes {
    echo "Stopping processes..."
    kill $DOCKER_PID
    kill $SYMFONY_PID
}

# Catch termination signal and stop processes
trap stop_processes SIGTERM

# Wait for both processes to finish
wait $DOCKER_PID
wait $SYMFONY_PID
