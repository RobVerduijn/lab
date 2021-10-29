# Installation media.

The play `playbooks/download_iso.yml` will download the iso images for:
* centos 8.4
* rocky 8.4
* fedora 34
* fedora 35
* virtio-win-01.208

Simply execute the playbook to download them.
```
cd playbooks
source venv/bin/activate
ansible-playbook download_iso.yml
```
