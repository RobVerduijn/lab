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

and your ready to go

Rob