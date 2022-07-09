###  ubuntu-20-devops-tools
This repo contains support files to create a devops environment on Ubuntu 20.04.


### VirtualBox Ubuntu 20.04 LTS Setup
Please follow the instructions in this video to set up your VM. The
instructions are for a Windows host, but should also work for Mac/Linux.

[Instructions to install Ubuntu on Oracle Virtual Box](https://www.youtube.com/watch?v=x5MhydijWmc)

### Additional information needed for the Virtual Box setup
[Link to downlod Ubuntu 20.04 ISO](https://releases.ubuntu.com/20.04/ubuntu-20.04.4-live-server-amd64.iso) 

* 4096mb memory (more is OK)
* 35Gb disk  (more is OK)
* 2 Virtual CPU's (more is OK)

### Todo before installing VirtualBox Guest additions
In a terminal run: (Super+Ctrl+T to launch Terminal) 

```
sudo apt install build-essential dkms linux-headers-$(uname -r)
```

### After completing the Virtual Box setup
### Install git
In a terminal run:
```
sudo apt-get install -y git
```

### Install VS Code
In a terminal run:
```
sudo snap install --classic code
```
Click 'start', then find code, start VSCode, add to Favorites on your toolbar

### Clone this repo
In a terminal run:
```
cd ~
mkdir git
cd git
git clone https://github.com/friedrich-brunzema/ubuntu-20-devops-tools.git
```

### Run script to install the tooling
Review the provision.sh script first, then

```
cd ubuntu-20-devops-tools.git
bash provision.sh
```