#!/bin/bash

# Check if the USERNAME environment variable is set
if [ -z "$USERNAME" ]; then
    echo "Error: USERNAME environment variable is not set."
    exit 1
fi

echo "Adding $USERNAME"

deluser ubuntu

generate_password() {
    # Generate a random password with a length of 12 characters
    # You can adjust the length and character set as needed
    tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 12
    echo
}
PASSWORD=$(generate_password)

adduser $USERNAME --gecos "" --disabled-password --uid 1000 --home /home
chown $USERNAME:$USERNAME /home
#echo "$USERNAME:$PASSWORD" | chpasswd

# Output the username and password
echo "User '$USERNAME' created with password: $PASSWORD"

echo "Starting SSH"
service ssh start

echo "Running forever"
tail -f /dev/null
