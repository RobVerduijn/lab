# Installation Media

The play `playbooks/download_iso.yml` will download all open source images for you.

Simply execute the playbook to download them.
```
cd playbooks
ansible-playbook download_iso.yml
```

RHEL 8<br>
If you do not have access to RHEL installation media you can obtain it performing the following steps:
* Sign up for a redhat developer account by clicking on the login button in the upper right corner on this [website](https://developers.redhat.com/)
* After the login has been created you can download the image [here](https://access.redhat.com/downloads/)

The redhat developer subscription allows you to run RHEL systems with a total of 16 cores.<br>
ie:<br>
1 vm with 16 cores or 16 vms with 1 core<br>
Any setup that has a total of 16 cores is valid.

Windows10<br>
You can download windows installtion media [here](https://www.microsoft.com/en-us/software-download/windows10ISO)<br>
select the following options:
* latest edition (there is only one option, but they make you choose)
* english language
* 64-bit

My playbooks have only been tested with english 64-bit, but feel free to try other options, please do let me know how they work out for you......

I've been using kms keys in my plays to install a windows machine
read more about kms keys [here](https://docs.microsoft.com/en-us/windows-server/get-started/kms-client-activation-keys)

You can find kms keys for most microsoft products on that page.