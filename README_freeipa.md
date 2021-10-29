# FreeIPA

This play requires the rocky8 image to be present.

Run the create_ipa_lab.yml playbook
```
ansible-playbook create_ipa_lab.yml
```

This will setup a FreeIPA server and setup a FreeIPA client desktop.

login | password | remarks
---|---|---
root|rockylinux|the local root user on both systems
admin|rockylinux|ipa admin account
student|student|ipa user account
directory manager|rockylinux|special account to manage the ldap directly

FreeIPA-Domain: linux.lab

FreeIPA-Realm: LINUX.LAB

When your browser gives you a hard time due to the ssl errors.<br>
Find the server ca cert at the following location.<br>
```
https://<freeipa server fqdn>/ipa/config/ca.crt
```
For the linux.lab environment you can download them using curl.:
```
cd /tmp<br>
curl -Ok https://ipa.linux.lab/ipa/config/ca.crt<br>
```
then import them into your browser to get rid of the ssl complaints.<br>
