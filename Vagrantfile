#  Creating vagrant VM for Jenkins on Ubuntu ARM64 from a docker image
#  First create the VM with: vagrant up
#  There will be an error " The permissions of the private key should be set to 0600..." for the private key permission since the vm is running from an external drive.
# The error can be resolved by running ssh_keys.sh which will move the key to the internal laptop storage, change the file permissions and add a link sunch that the vm can access the key.
# Enter the VM File System "vagrant ssh"
# Run "vagrant provision" to install Jenkins from the file "provision_jenkins.sh"


Vagrant.configure("2") do |config|

    # Define a named box to use
    config.vm.define "docker-jenkins" do |jenkins|
        jenkins.vm.box = "spox/ubuntu-arm"
        jenkins.vm.box_version = "1.0.0"
        jenkins.vm.hostname = "jenkins.local"
        # Once VM is up and running, this is the private key path on the internal storage of Macbook
        #jenkins.ssh.private_key_path = "~/Desktop/vms/vm_private_keys/ubuntu_jenkins_ssd/private_key"

        # Private network with static IP
        jenkins.vm.network "private_network", ip: "192.168.60.21"

        jenkins.vm.provider "vmware_desktop" do |vmware|
            vmware.gui = true
            vmware.allowlist_verified = true
            vmware.memory = 4096
            vmware.cpus = 2
        end
        # Provision Jenkins automatically
        jenkins.vm.provision "shell", path: "/provision/install_docker_jenkins.sh"
    end
end
