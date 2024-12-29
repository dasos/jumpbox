# Jumpbox
This is a simple Docker image that is to be used as a SSH jumpbox. I use it in my Kubernetes cluster, and can SSH into it to admin the cluster, and access other nodes.

## How to use it
Create a Docker or Kubernetes or whatever container with the following things:
1. Set an environment variable of USERNAME as you want
2. Create some SSH host keys, if you need to.
   * Something like:  `sudo ssh-keygen -t ed25519 -f ssh_host_ed25519_key -N ''`
3. Mount them into the container at `/keys`. Anything in this directory will be copied to `/etc/ssh/`.
4. Make a script, and mount it at `/usr/local/bin/install_script.sh`. It'll be executed as root when the container starts.
   * I use this to install extra packages that I need, like `kubectl`
6. You probably also want to mount `/home` on some durable storage.

### How I use it
In my K3S cluster, I store the host keys as secrets, the install script as a ConfigMap, and `/home` as a PVC. Then I define a NodePort service that lets me acccess my cluster anywhere I want. :)
