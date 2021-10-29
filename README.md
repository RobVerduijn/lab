# Ansible Collection - code.lab

Documentation for the collection.<br>
Working on it to get this repo to confirm to ansible-galaxy<br>

Create a playbook directory.
```
mkdir -p $HOME/code/playbooks
```
Create and activate your python venv.
```
cd $HOME/code/playbooks
python3 -m venv venv
source venv/bin/activate
pip3 install ansible-core
```
Install/update this collection.<br>
(requires venv to be active)
```
cd $HOME/code/playbooks
ansible-galaxy collection install -f git+https://github.com/RobVerduijn/lab.git
```
To also force update the dependencies.
```
ansible-galaxy collection install -f --force-with-deps git+https://github.comRobVerduijn/lab.git
```
sync the collection playbooks folder to your playbooks folder
```
cd $HOME/code/playbooks
rsync -av ~/.ansible/collections/ansible_collections/RobVerduijn/lab/playbooks/ \
  $HOME/code/playbooks/
```
Now run the setup_ansible_controller playbook to setup your controller.<br>
```
cd $HOME/code/playbooks
ansible-playbook setup_ansible_controller.yml
```
Check to see if the images are correct and the download urls are pointing to fast mirrors.<br>
And if the pools are pointing to the correct storage pools.<br>
```
cd $HOME/code/playbooks
cat group_vars/iso.yml
```
Run the download_iso playbook to download the images (which takes a very long time).<br>
```
cd $HOME/code/playbooks
ansible-playbook download_iso.yml
```
Then run the create_distro_image plays to create the backing images.<br>
which will become about 350Mb-450Mb in size.<br>
```
cd $HOME/code/playbooks
ansible-playbook create_centos8_image.yml
ansible-playbook create_centos8stream_image.yml
ansible-playbook create_rocky8_image.yml
ansible-playbook create_fedora34_image.yml
ansible-playbook create_fedora35_image.yml
```

See the following readmes for details
* [Katello lab ](README_katello.md)
* [FreeIPA lab ](README_freeipa.md)
* [Rocky, Centos and Fedora Media](README_rocky_centos_fedora_media.md)
* [RHEL Media](README_rhel_media.md)
* [Windows Media](README_windows_media.md) (Read it before trying it)