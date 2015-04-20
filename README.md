## Setup a docker with a SSH server running on a random port and customize it with ansible

### Prerequisites
In order for this to work, you must have:
* docker >= 1.5.0
* ansible >= 1.9
* python-jinja2
* python-yaml
* docker-py (install with pip)

For ubuntu, you can copy/paste
```bash
 sudo apt-get install ansible python-jinja2 python-yaml
 sudo pip install docker-py
```

### Usage
For DNS local settings to be automatically integrated in /etc/resolv.conf, either :
* add a dns option cf [ansible doc](http://docs.ansible.com/docker_module.html) in `dockerize.yml` :
```
...
volumes: "{{ the_volumes }}"
dns:
  - x.x.x.x
  - y.y.y.y
```
* edit your `/etc/default/docker` file :
```
DOCKER_OPTS="--dns x.x.x.x --dns y.y.y.y"
```

Copy vars_example.yml in vars.yml and set the parameters

Execute `./launch.sh path_to_save_docker_home_folder`

When the execution is over, you can enter the freshly configured docker with `./enter.sh`

If something goes wrong (Or you want to freshly restart for whatever reason), you can wipe everything with `STOP_AND_DELETE_ALL.sh`

#### What the script does

* build the docker image if you don't have it
 * creates a user developer
  * no password, sudoer
  * same uid of you
* create an instance of the docker image
 * mount /tmp/.X11-unix into /tmp/.X11-unix
 * set your $DISPLAY variable into docker
* launch ansible

#### Misc

The graphical capabilities are based on the work of http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/

#### Changes

* 2015-04-12
  * ssh is not needed anymore (ansible connection plugin)
  * docker is not a dockerception, but the docker host exposed inside the container (not very secure, but this is for a development environment)
