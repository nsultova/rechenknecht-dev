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


## Main features and design decisions
This playbook sets up and configures a workstation with a vanilla arch install. The setup is designed with testing in mind, around my approach to deploy step by step in the VM first and then transfer it to further testing on the workstation.

Currently, there are two groups:
    *\[machnines\]
    *\[vms\] 

Things are identical for both groups, except sections that recquire GPU||a lot of disk space, those get skipped when \[vms\] is specified.
I tend to work around with dummy-roles instead in that case.

The reason I decided to go for mamba, are:
* obviously keeping things separated
* enabling my friends to install what they need without needing sudo or spamming the system
* current ml-projects are often peculiar in terms of needs and dependencies, the approach with least headache seems to be to launch an environment via mamba and instapp pip + your-needed-python-version from _within and THEN install all further project-specific requirements via pip - again from within the env. Sucks but from all approaches I've worked with, the least painful and most reproducible so far 
* currently in no mood struggling with the docker vs wireguard vs kvm circus I ran into when initially planning to do it via containers
* also, afaik accessing the GPU via containers is non-trivial so maybe sth for the future, too much overkill for this setup 
* might still do so in future tho


### Structure

So far the playbook has following structure:
```
  roles:
    - name: roles/install
    - role: setup
    - role: updates
    - role: dummy-env
    - role: open-webui
      when: inventory_host name in groups['machines']
    - role: setup-new-user
```

##### role/install
* Sets up and configures yay
* Installs all packages listed in `config.yml` according to their sections

##### role/setup
* Configures some services, tools and working environment

##### role/updates
Updates can be automatically launched as as post-tasks too (see `site.yml`) but i currently prefer it this way whilst actively developing

##### role/dummy-env
Excluded by default, used this for finding out on how to make mamba run properly, kept it as conventient role for further experiments

##### role/open-webUI
Installs open-webUI in a dedicated mamba-env. 
Given space requiements only executed when "host=machines" is set 
#TODO: as it's technically groups the naming and way of calling is more than confusing, I hope to be able to find a better way
#TODO add further roles for various ML-applications

##### role/setup-new-user
Sets up a new user without sudo access and baseline configuration of some tools.
An initial password is generated via `mkpasswd --method=sha-512` and the hasehd value added in the according section in `vars/main.yml`
Ask your friend for their pub key and add it to `files`. Refer to it from within `main.yml`
#TODO Find a way to put this into `vars/main.yml` too



## How to run
##### Prerequisites:  
* ansible installed  on your host-system (as time of writing I am running ansible 2.17.0)
* vanilla arch installation
* a user with sudo
* working ssh between your host and the machine-to-be-deployed 
* UI - I choose KDE via the installer for convenience so it's not in the roles   

##### Initial setup
* `git clone https://github.com/nsultova/rechenknecht-dev.git`
* `cd rechenknecht-confiure`
* ensure you have your vanilla arch up and running and a working ssh connections
* add your credential as needed in `inventory`
* execute via `ansible-playbook -K site.yml -i inventory -e "host=machines"` 
* after initial setup, reboot 
    
## Testing and development (local kvm machine)
* Most things have been tested on a VM, you can set up a vanilla arch vm and run everything via
`ansible-playbook -K site.yml -i inventory -e "host=vms"` 

* sections that are specifically dependend on GPU/big disk requirements are skipped
* don't forget to configure your ssh-access and add your VM's credentials in `inventory`

