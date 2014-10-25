## Setup a docker with a SSH server running on a random port and customize it with ansible

### Prerequisites
In order for this to work, you must have: 
* ansible
* python-jinja2
* python-yaml
* docker-py (install with pip)
* an ssh key

For ubuntu, you can copy/paste
```bash
 sudo apt-get install ansible python-jinja2 python-yaml
 sudo pip install docker-py
```

### Usage
Copy vars_example.yml in vars.yml and set the parameters

Execute ./launch.sh

If you don't have the docker image, it will build it for you.

#### What the script does 

* build the docker image if you don't have it
 * creates a user developer
  * no password, sudoer
  * same uid of you ( hard coded to 1000 for now, if your uid and gid is not 1000, the graphical applications wont work)
 * Put your ssh public key into /root/.ssh/authorized_keys and /home/developer/.ssh/authorized_keys so you can log in without password
* create an instance of the docker image
 * mount /tmp/.X11-unix into /tmp/.X11-unix
 * set your $DISPLAY variable into docker
* launch ansible

#### Faq
If you have something like that:
```
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
 Someone could be eavesdropping on you right now (man-in-the-middle attack)!
 It is also possible that a host key has just been changed.
 The fingerprint for the ECDSA key sent by the remote host is
 58:45:5b:9f:c5:33:8d:15:45:2b:81:c9:b3:28:1c:39.
 Please contact your system administrator.
 Add correct host key in /home/yourhome/.ssh/known_hosts to get rid of this message.
 Offending ECDSA key in /home/yourhome/.ssh/known_hosts:13
   remove with: ssh-keygen -f "/home/yourhome/.ssh/known_hosts" -R [127.0.0.1]:220
 ECDSA host key for [127.0.0.1]:220 has changed and you have requested strict checking.
 Host key verification failed.
```

it means that you probably had another system running on port 220.
To get rid of this message, simply run the ssh-keygen command prompted by the message. In my case, this will be 'ssh-keygen -f "/home/yourhome/.ssh/known_hosts" -R [127.0.0.1]:220', stop your chroot and launch it again.


#### Misc

The graphical capabilities are based on the work of http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
