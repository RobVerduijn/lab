# RHEL installation media

If you do not have access to RHEL installation media you can obtain it performing the following steps:
* Sign up for a redhat developer account by clicking on the login button in the upper right corner on this [website](https://developers.redhat.com/)
* After the login has been created you can download the image [here](https://access.redhat.com/downloads/)

The redhat developer subscription allows you to run RHEL systems with a total of 16 cores.<br>
ie:<br>
1 vm with 16 cores or 16 vms with 1 core<br>
Any setup that has a total of 16 cores is valid.

The playbooks have been tested on rhel8<br>
Backwards compatibility with rhel7 would take quite some effort to fix.<br>

RHEL6 doesn't even work properly with ansible which would require a huge overhaul of the collection so it's not gonna happen.<br>
Especially since it's eol.


# Known Issue:
For a full unattended rhel backing image creation, you need to specify your redhat login in the `group_vars/all/secrets.yml`<br>
see `group_vars/all/all.yml` for the variable names.<br>

If you use a different name for the file containing your credentials<br>
Make sure you add the file to your **.gitignore**.<br>
also **encrypt** them with ansible_vault.<br>
You really don't want to accidently share them.

This is required so that the play can subscribe the system to download the latest updates.
See the role `RobVerduijn.lab/roles/subscription` for details on what they are used for.

If you don't specify them the play will halt and prompt you for the login and password.