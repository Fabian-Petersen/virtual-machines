Issues Creating the VM

- Error installing docker command ""
  FIX: Add -y flag to all 'apt-get' else 'sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin' will fail. The command expect user interaction and timeout with exit.

Error "http:192.168.60.21:8080 fails to connect"
FIX:

- Check if private IP is assigned to the VM and is unique from other VM's running
- check if the VM can be received by the host machine "ping 192.168.60.21" failed to connect
- Check if VM can be called from inside the machine "ping 8.8.8.8" no packet loss hence machine can be reached.
- Check if VM has IP assigned "ip a" from inside the VM (No IP was assigned)
- Exit VM and reboot "vagrant reboot docker-jenkins"
- Check again "IP was correctly assigned"

[INFO]: Logging into Jenkins /var/jenkins_home/secrets/initialAdminPassword for the initial password retun "no directory found"

- The reason jenkins run inside the container and is not directly accessible in the machine file system.
  FIX:
- Get the password from inside the container
- Run as user jenkins "root user can still fail"
  docker exec -u jenkins jenkins cat /var/jenkins_home/secrets/initialAdminPassword.
- This will print the initial password to the console.
