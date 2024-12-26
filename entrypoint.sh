#!/bin/bash

# Check if the USERNAME environment variable is set
if [ -z "$USERNAME" ]; then
    echo "Error: USERNAME environment variable is not set."
    exit 1
fi

echo "Adding $USERNAME"
adduser $USERNAME --gecos "" --disabled-password --home /home
echo "$USERNAME:$PASSWORD" | chpasswd

# Output the username and password
echo "User '$USERNAME' created with password: $PASSWORD"

echo "Running forever"
tail -f /dev/null
