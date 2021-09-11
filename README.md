# Ansible Collection - code.lab

Documentation for the collection.
Working on it to get this repo to confirm to ansible-galaxy

For now install/update with:

    ansible-galaxy collection install -f git+https://github.com/RobVerduijn/lab.git  
To also force update the dependencies:

    ansible-galaxy collection install -f --force-with-deps git+https://github.com/RobVerduijn/lab.git

make a copy of the playbook folder somewhere

    mkdir -p $HOME/code
    cp -r ~/.ansible/collections/ansible_collections/RobVerduijn/lab/playbooks $HOME/code/playbooks
change to your playbook folder and run
ansible-playbook setup_ansible_controller.yml

activate your venv

    cd $HOME/code/playbooks
    source venv/bin/activate
check to see if the images are correct and the download urls are pointing to fast mirrors

    cd $HOME/code/playbooks
    vi group_vars/iso.yml 
and if the pools are pointing to the correct storage pools
run the download_iso playbook to download the images (which ofcourse takes a long time)

then run the create_distro_image plays to create the backing images which will become a bit over 300Mb in size.
    
    cd $HOME/code/playbooks
    ansible-playbook create_centos8_image.yml
    ansible-playbook create_centos8stream_image.yml
    ansible-playbook create_rocky8_image.yml
    ansible-playbook create_fedora34_image.yml

now you could run one of the following:
- create_linux_lab.yml play which will create and start 4 linux systems
- create_katello_lab.yml which will setup a basic katello server
- create_ipa.linux.lab.yml which will setup a basic ipa server with dns

Keep an eye on your ram/cpu usage when you do this, your system might not be capable of runnin all the vm's at the same time

when your browser gives you a hard time due to the ssl errors
server ca cert locations
freeipa

    https://<freeipa server fqdn>/ipa/config/ca.crt
katello

    https://<katello server fqdn>/pub/katello-server-ca.crt

download with:

    cd /tmp
    curl -Ok https://ipa.linux.lab/ipa/config/ca.crt
    curl -Ok https://katello.linux.lab/pub/katello-server-ca.crt
then import them into your browser to get rid of the ssl complaints

Rob