# FreeIPA

Run the create_ipa_lab.yml playbook to automatically install an freeipa server and a rocky8 system that you can use to practise with.
```
ansible-playbook create_ipa_lab.yml
```

This play requires the rocky8 image to be present.

When your browser gives you a hard time due to the ssl errors.<br>
Find the server ca cert at the following location.<br>
freeipa
```
https://<freeipa server fqdn>/ipa/config/ca.crt
```
For the linux.lab environment you can download them using curl.:
```
cd /tmp<br>
curl -Ok https://ipa.linux.lab/ipa/config/ca.crt<br>
```
then import them into your browser to get rid of the ssl complaints.<br>
