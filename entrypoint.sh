#!/bin/bash

# Check if the USERNAME environment variable is set
if [ -z "$USERNAME" ]; then
    echo "Error: USERNAME environment variable is not set."
    exit 1
fi

echo "Deleting all host keys"
rm /etc/ssh/ssh_host_*
echo "Copying over provided keys"
cp /keys/* /etc/ssh/

echo "Adding $USERNAME"

# Delete the OOTB user
deluser ubuntu

# Disabling password, since we'll auth with ssh key
adduser $USERNAME --gecos "" --disabled-password --uid 1000 --home /home
chown $USERNAME /home
#echo "$USERNAME:$PASSWORD" | chpasswd

# Output the username and password
echo "User '$USERNAME' created with password: $PASSWORD"

echo "Starting SSH"
service ssh start

echo "Running forever"
tail -f /dev/null
