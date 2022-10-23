###  ubuntu-20-devops-tools
This repo contains support files to create a devops environment on Ubuntu 20.04. The tools are all open-source.


### VirtualBox Ubuntu 20.04 LTS Setup
Please follow the instructions in this video to set up your VM. The
instructions are for a Windows host, but should also work for Mac/Linux. I suggest watching this even if you know what you are doing.
[Instructions to install Ubuntu on Oracle Virtual Box](https://www.youtube.com/watch?v=x5MhydijWmc)

### Additional information needed for the Virtual Box setup
[Link to downlod Ubuntu 20.04 ISO](https://releases.ubuntu.com/20.04/ubuntu-20.04.4-live-server-amd64.iso) 

* 4096mb memory (more is OK)
* 35Gb disk (more is OK)  OS and tools will use about 15gb
* 2 Virtual CPU's (more is OK)

### Todo before installing VirtualBox Guest additions
In a terminal run: (Super+Ctrl+T to launch Terminal) 

```
sudo apt install -y build-essential dkms linux-headers-$(uname -r)
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
cd $HOME/git/ubuntu-20-devops-tools
bash provision.sh
```

### What does the script install in terms of standard Ubuntu packages that is interesting?
Package name | Comments
:--- | :--- |
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
curl | Command line REST utility.
 


### Other devops tools that are installed:
Tool Name | Version | Comments
:---|:---|:---
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

### Installed Krew plugins (subset of useful ones shown)
Name | Comments
:--- | :---
kubectl neat | Cleans up yaml rendered by -oyaml.
kubectl ns | Switches default namespaces. Shows current ns.
kubectl deprecations | Shows K8s API deprecations.
kubectl node-shell | Allows you to 'ssh' into a worker node by name.
kubectl skew | Shows versions of your cluster vs kubectl version.
kubectl view-secret | Dumps secrets with built-in base64 decoding.

##  Installed Visual Studio Code Extensions
Name | What it does
:--- | :---
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

## Other features
* Syntax highlighting in the terminal, see [here](https://linuxhint.com/enable-syntax-highlighting-zsh/).
* Supercharged 'cd' command, zsh-z aliased to 'j', see [here](https://github.com/agkozak/zsh-z).
* useful git aliases (stored in ~/.gitconfig).
* zsh-kubectl-prompt -- useful prompt to indicate cluster and namespace

## Useful git aliases (you can see them all in ~/.gitconfig)
Also see the standard zsh git shortcuts [here](https://kapeli.com/cheat_sheets/Oh-My-Zsh_Git.docset/Contents/Resources/Documents/index)
Name | What it does
:--- | :---
git addall | Equivalent to git add . --all.
git st | Equivalent to git status.
git cm "msg" | Equivalent to git -am "msg".
git branch-name | equivalent to git rev-parse --abbrev-ref HEAD.
git publish | Pushes new branch to origin, equivalent to git push -u origin [current branch].
git unpublish | Deletes the branch on the server, equivalent to git push -u :branch.
git co | Equivalent to git checkout.
git conflicts | Shows conflicted files, diff --name-only --diff-filter=U.
git squash | Does interactive rebase from where you branched from develop branch.
git current | Shows the sha1 of the HEAD commit.
git cob | Equivalent to git checkout -b.

## Git with ssh
The script will create a ~/.ssh/id_rsa (private key) and ~/.ssh/id_rsa.pub (public key). The .zshrc will start an ssh agent and load the key, but for things to work you must upload your public key to Github or git provider. More info about github and ssh can be found [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

## Opening a ZSH shell by default in vscode.
VSCode will open a bash shell by default.  You can either type zsh to get the zshell one.
1. Open Visual Studio Code.
2. Press CTRL + SHIFT + P to open the Command Palette.
3. Search for “Terminal: Select Default Profile” (previously “Terminal: Select Default Shell”)
4. Pick zsh

## Python script utilites
To use these, you should make sure they are executable (chmod +x) and copy them to a place like ~/.local/bin
Script name | What it does | Example
:--- | :--- | :---
dns4elb | This script allows you to check if an amazon elb dns name corresponds to a dns name. When using ingress on AWS EKS, the ingress points to a ELB/ALB loadbalancer name, but also usually has a DNS name.  The external-dns deployment takes care of creating and pointing the DNS name to the ELB/ALB.  To make sure the assignent happened, you can use this utility, which looks up the IP's and compares them. | dns4lb foo.myhost.com c9287718dbf8d453db55e7628ce240b8-173467794.us-east-2.elb.amazonaws.com 
wait4dns | This is useful when your company DNS updates are slow.  After publishing a new service, Route53 will publish the new name, but this takes some time to propagate to your ISP's domain name server or company DNS if you are on a VPN.  Propagation can take a while (sometimes 15 mins or more), and you typically want to know when the record is available so that you can use the service. wait4dns does an automatic dns lookup every second, and exits when the name is available. If the dns entry is there, it will exit immediately.| wait4dns google.ca
