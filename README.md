Decided to learn some automation with ansible for my arch machine-learning setup, expecting to break things rather often. 
Crude, ongoing WIP :) Aiming for it to be useful for others too, adding some docs in case anyone needs a place to start for their own project. 

Current state 14-06-2024:
* Roles for setting up a vanilla arch system with addding various tools and custom configurations
* currently mamba is the environment manager of choice, simply because ML depencencies are cumbersome and I want my friends to be able to install things without sudo
* might add containers later but rn in no mood struggling with the docker vs wireguard vs kvm circus 
* Adding new users to the system with everything configured to allow them play around with ML 

-------


# Automated ArchLinux
This ansible playbook automates my personal machine learning setup on Arch Linux.

### Use Case:
I have a workstation with a RTX A4000 Nvidia GPU and want to use it as major playground especially for local AI-models. 
Furthermore as sharing is caring, thus I want to be able to give access to some friends
The workstation is only accessible trough Wireguard, thus if you plan to adapt any of this keep that in mind - especially when it comes to further-down details on configuring exposure of open-webUI etc.



## Main features of this installation
This playbook sets up and configures a workstation with a vanilla arch install. The setup is designed with testing in mind, around my approach to deploy step by step in the VM first and then transfer it to further testing on the workstation.

Currently, there are two groups:
    *\[machnines\]
    *\[vms\] 

Things are identical for both groups, except sections that recquire GPU||a lot of disk space, those get skipped when \[vms\] is specified.
I tend to work around with dummy-roles instead in that case.

So far the playbook has following structure:
```
  roles:
    - name: roles/install
    - role: setup
    - role: updates
    - role: dummy-env
    - role: open-webui
      when: inventory_hostname in groups['machines']
    - role: setup-new-user
```

##### roles/install




##### Prerequisites:  
* ansible installed  on your host-system (as time of writing I am running ansible 2.17.0)
* vanilla arch installation
* a user with sudo
* working ssh between your host and the machine-to-be-deployed 
* UI - I choose KDE via the installer for convenience so it's not in the roles   



## Additional features

## How to run
* `git clone https://github.com/nsultova/rechenknecht-dev.git`
* `cd rechenknecht-confiure`
* ensure you have your vanilla arch up and running and a working ssh connections
* add your credential as needed in `inventory`
* execute via `ansible-playbook -K site.yml -i inventory -e "host=machines"` 
    

``` bash
$ sudo pacman -S ansible
```

then download the playbook and make sure you adjust the values of the global
config in `group_vars/all` to match your system stats. Then run it.

``` bash
$ git clone --recurse-submodules -j8 https://github.com/id101010/ansible-archlinux.git
$ cd ansible-archlinux/ansible
$ ansible-playbook -i inventory/localhost playbook.yml [--tags $LIMIT_TO_TAG]
```

Lean back and watch the installation.

## Testing and development (local kvm machine)
* Most things have been tested on a VM, you can set up a vanilla arch vm and run everything via
`ansible-playbook -K site.yml -i inventory -e "host=vms"` 

* sections that are specifically dependend on GPU/big disk requirements are skipped
* don't forget to configure your ssh-access and add your VM's credentials in `inventory`

```

Now reboot the machine and start a graphical session using virtualbox. The
default credentials are `user:vagrant pw:vagrant`.  Alternativly you can log
into your machine using the command `vagrant ssh`.

Hint: To reload the configuration into the vagrant box you can eighter reload
(issues a graceful shutdown) the machine using `vagrant reload` or you can
update and apply the configuration changes using `vagrant rsync && vagrant
provision`.  This way you don't need to wait for the machine to boot when
testing changes.