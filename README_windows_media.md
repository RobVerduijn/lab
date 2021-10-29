# Windows Installation Media

For reasons known by microsoft it is not possible to simply use an url to download windows installation media.

Windows10<br>
You can download windows10 installation media [here](https://www.microsoft.com/en-us/software-download/windows10ISO)<br>
Windows11<br>
You can download windows11 installation media [here](https://www.microsoft.com/nl-nl/software-download/windows11)<br>

select the following options:
* latest edition (there is only one option, but they make you choose)
* english language
* 64-bit

My playbooks have only been tested with english 64-bit, but feel free to try other options, please do let me know how they work out for you......

I've been using kms keys in my plays to install a windows machine
read more about kms keys [here](https://docs.microsoft.com/en-us/windows-server/get-started/kms-client-activation-keys)

You can find kms keys for most microsoft products on that page.<br>

Windows11 pro works with the same kms key as Windows10 pro

# Known issue
The Windows 11 backing image creation requires you to press the space-bar once to boot from the iso media.<br>

The only way to bypass that is a modified installation iso.<br>
I haven't found a way to automate that yet.<br>
I guess by generating a new iso from the installation media while ommiting the the file bootfix.bin

microsoft really creates the impression that it does not want you to automate this stuff....<br>
They keep referring to painstakingly preparing all this stuff over and over again after each update using their mdt kit (microsoft deployment tools)<br>
A kit that requires an awfull lot of manual error prone editting.