#!/bin/bash

# Check if the USERNAME environment variable is set
if [ -z "$USERNAME" ]; then
    echo "Error: USERNAME environment variable is not set."
    exit 1
fi

echo "Adding $USERNAME"
adduser $USERNAME --home /home

echo "Running forever"
tail -f /dev/null
