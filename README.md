# Ansible Collection - code.lab

Documentation for the collection.
Working on it to get this repo to confirm to ansible-galaxy

For now install/update with:

    ansible-galaxy collection install -f git+https://github.com/RobVerduijn/lab.git  
To also force update the dependencies:

    ansible-galaxy collection install -f --force-with-deps git+https://github.com/RobVerduijn/lab.git

make a copy of the playbook folder somewhere
change to your playbook folder and run
ansible-playbook setup_ansible_controller.yml

activate your venv

    source venv/bin/activate

in your playbook folder
check to see if the images are correct and the download urls are pointing to fast mirrors
    vi group_vars/iso.yml 
and if the pools are pointing to the correct storage pools
run the download_iso playbook to download the images (which ofcourse takes a long time)

then run the create_distro_image plays to create the backing images which will become a bit over 300Mb in size.

now you could try
the create_linux_lab.yml play which will create and start 4 linux systems
the create_ipa.linux.lab.yml play which will setup an ipa server
or the
create_katello_standalone which will setup a katello server

Rob
