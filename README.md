###  ubuntu-20-devops-tools
This repo contains support files to create a devops environment on Ubuntu 20.04.


### VirtualBox Ubuntu 20.04 LTS Setup
Please follow the instructions in this video to set up your VM. The
instructions are for a Windows host, but should also work for Mac/Linux. I suggest watching this even if you know what you are doing.
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

### What does the script install in terms of standard Ubuntu packages that is interesting?
Package name | :Comments
--- | --- |
build_essential | Compiler needed to build tools.
wget | Tool to do a REST get from an HTTP(s) server.
figlet | Tool to display large text titles.
git-lfs | Git extension to allow handling large files.
default-mysql-client | The mysql cli tool to acces MySql databases.
jq | Json query tool.
tmux | Terminal virtualizer, keeps ssh sessions from timing out.
vim | Editor.
dnsutils | Dns lookup tools like dig and nslookup
openssl | To mess with certificates, and other crypt stuff.
zip | Command line zip tool.
unzip | Command line unzip tool.
ssh | Ssh client.
xclip | Command line tool that allows copying to clipboard, alias=clip
python3 pip | To install python libs.
zsh | Installs an alternate shell to bash.
 


### Other devops tools that are installed:
Tool Name | Version | Comments
---|---|---
git | latest | Clones the git repo, and recompiles and installs it.  Newer version needed for sparse checkouts.
aws_cli | 2.4.27| AWS command line utility.
kubectl | 1.22.2 | To control Kubernetes/EKS clusters. For K8s v 1.22.
helm | 3.8.1 | To install helm charts (software packages) for K8s.
terraform | 1.1.7 | To provision cloud infrastructure.
terragrunt | 0.36.6 | To provision cloud infrastructure.  Wrapper around terraform.
aws-iam-authenticator | 0.5.5 | Needed to authenticate to EKS cluster.
cloud-nuke | 0.11.3 | To destroy cloud infrastructure.  *Use at your own risk!*
sops | 3.7.2 | Mozilla sops.  Tool to encrypt/decrypt secrets.
krew | 0.4.2 | Plugin manager for Kubernetes.  See installed plugins below.
packer | 1.7.9 | Tool to create Amazon Machine Images (Ami's) programmatically.
argo | 3.2.6 | Tool to manage kubernetes argo workflows.
argocd | 2.3.1 | Tool to manage argo-cd (a Kubernetes deployment tool).
kustomize | 4.5.2 | Tool to customize manifests deployed to K8s
redis-cli | latest | Compiled from source.  To interact with redis cache servers.
oh-my-zsh | latest | Shell tooling and themes for zsh.
kubescape | 2.0.149 | Open source K8s security scanner.
docker | 20.10.17 | To manage containers and build images.
exa | 010.1 | Prettier, clearer ls utility.

### Installed Krew plugins (suset of useful ones shown)
Name | Comments
--- | ---
kubectl neat | Cleans up yaml rendered by -oyaml.
kubectl ns | Switches default namespaces. Shows current ns.
kubectl deprecations | Shows K8s API deprecations.
kubectl node-shell | Allows you to 'ssh' into a worker node by name.
kubectl skew | Shows versions of your cluster vs kubectl version.
kubectl view-secret | Dumps secrets with built-in base64 decoding.

##  Installed Visual Studio Code Extensions
Name | What it does
--- | ---
Packer | Provides syntax highlighting for .pkr.hcl files.
vscode-base64 | Allows in-place base64 encoding/decoding.  Useful in dealing with secrets.
unique-lines | Removes duplicate lines.
xml | Allows pretty-printing xml.
json-pretty-printer | Allows pretty-printing json.
open-in-terminal | Allows you to click on a folder, run the open in terminal command. Opens terminal with the folder as current directory.
terraform | Terraform .hcl syntax highligher.
vscode-kubernetes-tools | Gives you a right-click kubectl apply functionality from vs code explorer.
python | Pyhon language support.
subtle-brackets | Allows you to visualize which bracket matches with corresponding one in  unobtrusive way.
vscode-hex dump | Shows your content as hex dump.
jumpy | Allows crazy keyboard navigation.
better-align | Allows alignment of code.
tabspacer | Helps convert tabs to spaces and vice versa.
git lens | Mostly useful for git diffs directly in vscode.
yaml | Yaml language support for vscode.

