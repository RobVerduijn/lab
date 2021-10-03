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
python3 -m venv
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
Check to see if the images are correct and the download urls are pointing to fast mirrors.
```
cd $HOME/code/playbooks
cat group_vars/iso.yml
```
And if the pools are pointing to the correct storage pools.<br>
Run the download_iso playbook to download the images (which takes a very long time).<br>
```
cd $HOME/code/playbooks
ansible-playbook download_iso.yml
```
Then run the create_distro_image plays to create the backing images.<br>
which will become a bit over 300Mb in size.<br>
```
cd $HOME/code/playbooks
ansible-playbook create_centos8_image.yml
ansible-playbook create_centos8stream_image.yml
ansible-playbook create_rocky8_image.yml
ansible-playbook create_fedora34_image.yml
```
now you could run one of the following:
- create_linux_lab.yml play which will create and start 4 linux systems.
- create_katello_lab.yml which will setup a basic katello server.
- create_ipa.linux.lab.yml which will setup a basic ipa server with dns.<br>

Keep an eye on your ram/cpu usage when you do this, your system might not be capable of runnin all the vm's at the same time.<br>
Edit the play when needed (find the vms var).<br>

When your browser gives you a hard time due to the ssl errors.<br>
Find the server ca cert at the following locations.<br>
freeipa
```
https://<freeipa server fqdn>/ipa/config/ca.crt
```
katello
```
https://<katello server fqdn>/pub/katello-server-ca.crt
```
For the linux.lab environment you can download them using curl.:
```
cd /tmp<br>
curl -Ok https://ipa.linux.lab/ipa/config/ca.crt<br>
curl -Ok https://katello.linux.lab/pub/katello-server-ca.crt<br>
```
then import them into your browser to get rid of the ssl complaints.<br>

## Known issue
I have yet to figure out a way to completely automate the discovery config.<br>
Currently manual configuration is still required.<br>
From the [docs](https://theforeman.org/plugins/foreman_discovery/)<br>
Find the **Default PXE global template entry** option (or use the search in settings menu)<br>
And set the **Default PXE global template entry** to 'discovery'.
```
Administer -> settings-> Provisioning -> Default PXE global template entry == discovery
```
Then re-build the pxe default config.<br>
Find the **Build PXE Default** button and click it.<br>
```
Hosts -> Provisioning Templates -> Build PXE Default
```
Discovery can now be used for bare metal systems (or a vm without an os with network boot enabled)

Rob
