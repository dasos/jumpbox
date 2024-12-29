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

# No password, since we'll auth with ssh key
adduser $USERNAME --gecos "" --disabled-password --uid 1000 --home /home
chown $USERNAME /home
#echo "$USERNAME:$PASSWORD" | chpasswd

# Securing SSH
echo "Updating SSH config file"
sed -i 's/^#\?PasswordAuthentication yes/PasswordAuthentication no/' "/etc/ssh/sshd_config"
sed -i 's/^#\?PermitRootLogin yes/PermitRootLogin no/' "/etc/ssh/sshd_config"

# Allowing no password sudo
echo "Updating sudoers"
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

echo "Starting SSH"
service ssh start

FILE="/usr/local/bin/install_script.sh"
FILE_CP="/usr/local/bin/install_script_cp.sh"

# Check if the file exists
if [ -f "$FILE" ]; then
    echo "$FILE exists."

    cp "$FILE" "$FILE_CP"
    # Change the file permissions to make it executable
    chmod +x "$FILE_CP"
    echo "Changed permissions to make $FILE executable."

    # Run the file
    ./"$FILE_CP"
else
    echo "$FILE does not exist."
fi


echo "Running forever"
tail -f /dev/null
