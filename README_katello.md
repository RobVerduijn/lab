# Katello
This play requires the centos8 image to be present.

Run the create_katello_lab.yml playbook, this will take aproximatly 1 hour to complete
```
ansible-playbook create_katello_lab.yml
```

This will setup a katello server with a minimal configuration.
The following plugins will be configured:
- remote ssh execution
- ansible

In the file `playbooks/groupvars/katello/installation.yml` 5 more options have been disabled so you can practise your skills with katello.<br>
If you simply want to see a full fledged katello server set the following options to true:
* foreman_configure_infrastructure: true<br>
  this will setup infrastructure

* foreman_configure_proxies: true<br>
  requires foreman_configure_infrastructure to be true<br>
  this will enable the following proxies<br>
  * dns 
  * dhcp 
  * tftp
  * discovery<br>

* foreman_configure_content: true<br>
  requires foreman_configure_proxies to be true
  this will setup content:
  * products
  * repositories
  * lifecycles, 
  * content views, 
  * activation keys

* foreman_configure_hosts: true<br>
  this wil setup operating systems
  requires foreman_configure_content to be true

* foreman_configure_configure: true<br>
  this wil setup host groups
  requires all previous options to be true


login | password | remarks
---|---|---
root|centos84|the local root user on both systems
admin|katello42|katello admin account


When your browser gives you a hard time due to the ssl errors.<br>
Find the server ca cert at the following location.<br>
```
https://<katello server fqdn>/pub/katello-server-ca.crt
```
For the linux.lab environment you can download them using curl.:
```
cd /tmp<br>
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