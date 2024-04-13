# Secure use of the ansible vault password

Ansible [documentation](https://docs.ansible.com/ansible/latest/vault_guide/vault_managing_passwords.html#storing-passwords-in-third-party-tools-with-vault-password-client-scripts) can be a bit difficult to read and understand if you are new to this.

This document will describe the steps needed to securely store and use the vault password with an Ansible playbook.

## Table of Contents

- [Secure use of the ansible vault password](#secure-use-of-the-ansible-vault-password)
  - [Table of Contents](#table-of-contents)
  - [Steps](#steps)
    - [Create a personal gpgp keypair](#create-a-personal-gpgp-keypair)
    - [Encrypt vault password file](#encrypt-vault-password-file)
    - [Create a gpg-decrypt script](#create-a-gpg-decrypt-script)
    - [Add the script to the ansible inventory](#add-the-script-to-the-ansible-inventory)

## Steps

- Create a personall gpg keypair
- Encrypt the vault password with gpg
- Create a gpg-decrypt scipt
- Add script to the ansible inventory

### Create a personal gpgp keypair

There are two similar gpg commands.

- gpg is for the cli
- gpg2 is for use with a desktop

On each system you must create a unique gpg keypair.
Don't use the same password for each of your gpg keys.
Use a strong password that you store in a keyring or password manager.

To create a private gpg keypair issue the following command, and answer the questions as prompted. (use your real name and email address)

```bash
gpg --gen-key
gpg (GnuPG) 2.2.20; Copyright (C) 2020 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

### Encrypt vault password file

Create a plain text containing your vault password.  
>should be easy as you probably have one already, shame on you....

```bash
gpg --encrypt --recipient your@email.address -o ~/.vault_pass.gpg plain-text-vault-password-file
```

This will create an encrypted file called `.vault_pass.gpg` in your home directory.

You can decrypt this file with the following command:

```bash
gpg --decrypt .vault_pass.gpg
```

The gpg-agent will prompt you for your password, and then will decrypt the file.

For the duration of this session the gpg-agent will remember the password so you don't have to enter it every time.

Now securely delete that plain text vault password file.

```bash
shred plain-text-vault-password-file
```

### Create a gpg-decrypt script

To enable ansible to use the gpg encrypted vault password file we need to create a shell script that can decrypt the vault password.  
>Do **NOT!!** put it in an environmental variable, as this completely defeats the purpose of encrypting the vault password!

Issue the following command to create the script:

```bash
[! -e ~/.local/bin ] && mkdir -p ~/.local/bin
cat > ~/.local/bin/vault_.sh <<EOF
#!/usr/bin/env bash
gpg --decrypt .vault_pass.gpg 2>/dev/null
EOF
chmod +x ~/.local/bin/vault.sh
```

Test the script:

```bash
~/.local/bin/vault.sh
```

If you did not start a new shell session after creating the script, then the gpg-agent provide the password to the script automatically, if not the gpg-agent will prompt for you for your password.

### Add the script to the ansible inventory

To make ansible aware of the script we need to add it to the ansible inventory file.

This is dreadfully simple.

In the inventory file  `hosts.yml` add the following line:

```yaml
all:
  hosts:
    hosta:
      hosta_var1: one
      hosta_var2: two
    hostb:
      host_name: 10.0.0.1
    hostc:
    hostd:
  vars:
    global_var1: three
    global_var2: four
    ansible_password_file: ~/.local/bin/vault.sh
    ansible_password: !vault |
      $ANSIBLE_VAULT;1.1;AES256;
      010101010101010101010
      010101010101010101010
  children:
    production:
      hosts:
        hostc:
      vars:
        ansible_password_file: ~/.local/bin/vault_prod.sh
        ansible_password: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          101010101010101010101
          101010101010101010101
```

The use of an inventory hosts file in yaml format also makes it very easy to add different vault decryption scripts for different environments like production, staging and development.
> making the vault.sh script compatible with vault id is a bit more complicated but still possible.  
It should accept the --vault-id parameter and the value it is set to.