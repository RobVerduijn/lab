# Katello
When your browser gives you a hard time due to the ssl errors.<br>
Find the server ca cert at the following location.<br>
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