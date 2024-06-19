Hey :3

### General
The way to install and play with things is currently done via mamba.
If you want a new environment you can create it via:
`mamba env create --env my-env`

and activate it via:
`mamba activate my-env`

What I recommend based on own experience for ML-thingies is to get a mamba-env, install the necessary python-version and pip from within and then use pip for whatever comes your way

For more information, see https://mamba.readthedocs.io/en/stable/user_guide/mamba.html

When it comes to docker, I haven't set it up yet due to $reasons, might add it in future

If you want to have information about the gpu:
`nvidia-smi`

If you need any tool installed outside mamba, lmk :)

Oh, and don't forget to change your password 


### Examples
Access open-WebUI:
* log in via ssh on the workstation 
* (again here, there's a wireguard in between so you need to do your own configuration here)

* launch a tmux session (bc you don't want your session to die together with your ssh connection)

* activate the custom mamba environment (from within tmux session):
`mamba env activate open-webui-env`

* cd into the open-webUI folder and start the server using:
`open-webui serve`

* Server should be listening on localhost:8080


* From your host, connect via:
`waypipe -c lz4=9 ssh nea@10.0.20.164 firefox`

* Now, the workstations firefox should pop-up on your machine

* access open-webUI via
`http://127.0.0.1:8080`
* ..and you're good to go :)