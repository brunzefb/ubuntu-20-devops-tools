#!/bin/bash

function install_base_packages() {
  export DEBIAN_FRONTEND=noninteractive
  sudo apt-get update 
  sudo apt-get install -y curl gnupg
  sudo apt-get update && sudo apt-get install -y \
      locales \
      locales-all \
      build-essential \
      wget \
      figlet \
      git-lfs \
      default-mysql-client \
      jq \
      tmux \
      vim \
      dnsutils \
      openssl \
      zip \
      groff \
      direnv \
      unzip \
      ssh \
      less \
      xclip \
      zsh \
      bc \
      netcat \
      apt-transport-https \
      ca-certificates \
      software-properties-common \
      libssl-dev\
      libghc-zlib-dev \
      libcurl4-gnutls-dev \
      libexpat1-dev \
      python3-pip \
      gettext

  pip3 install virtualenvwrapper
}

function install_git() {
  cd /tmp
  git clone https://github.com/git/git
  cd git
  sudo make prefix=/usr/local all
  sudo make prefix=/usr/local install
  cd /tmp
  sudo rm -rf git
}

function install_aws_cli() {
  cd /tmp
  curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-$AWSCLI_VERSION.zip" -o "awscli.zip"
  unzip -q awscli.zip
  sudo ./aws/install > /dev/null
  cd /tmp
  sudo rm -rf aws
}

function install_kubectl() {
  sudo curl -L https://dl.k8s.io/release/v$KUBE_LATEST_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
  sudo chmod +x /usr/local/bin/kubectl
}

function install_helm() {
  # helm3
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  sudo bash get_helm.sh && rm get_helm.sh
  helm plugin install https://github.com/hickeyma/helm-mapkubeapis
}


function install_terraform() {
  # using variable causes it to not work.
  wget --quiet https://releases.hashicorp.com/terraform/1.1.4/terraform_1.1.4_linux_amd64.zip      
  unzip -q terraform_1.1.4_linux_amd64.zip
  sudo mv terraform /usr/bin/terraform
  rm terraform_1.1.4_linux_amd64.zip
}

function install_terragrunt() {
  curl -fsSL -o terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/$TERRAGRUNT_VERSION/terragrunt_linux_amd64
  chmod +x terragrunt
  sudo mv terragrunt /usr/local/bin/terragrunt
}

function install_aws_iam_authenticator() {
  curl -fsSL -o aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.5/aws-iam-authenticator_0.5.5_linux_amd64
  chmod +x ./aws-iam-authenticator
  sudo mv aws-iam-authenticator /usr/bin
}

function install_cloud_nuke() {
  wget --quiet https://github.com/gruntwork-io/cloud-nuke/releases/download/$CLOUD_NUKE_VERSION/cloud-nuke_linux_amd64
  sudo mv cloud-nuke_linux_amd64 /usr/bin/cloud-nuke
  sudo chmod +x /usr/bin/cloud-nuke
}

function install_sops() {
  wget --quiet https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux
  chmod +x sops-v${SOPS_VERSION}.linux
  sudo mv sops-v${SOPS_VERSION}.linux /usr/local/bin/sops
}

function install_krew() {
  cd "$(mktemp -d)"
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/$KREW_VERSION/krew-linux_amd64.tar.gz"  
  tar zxvf krew-linux_amd64.tar.gz
  KREW=./krew-linux_amd64
  "$KREW" install krew
  sudo mv /$HOME/.krew/bin/kubectl-krew /usr/local/bin
}

function install_packer() {
  cd /tmp
  wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
  unzip -q packer_${PACKER_VERSION}_linux_amd64.zip
  sudo mv packer /usr/bin/packer
}

function install_krew_plugins() {
  export PATH="/usr/local/bin:${PATH}:${HOME}/.krew/bin"
  kubectl krew install neat
  kubectl krew install ns
  kubectl krew install doctor
  kubectl krew install deprecations
  kubectl krew install ingress-nginx
  kubectl krew install minio
  kubectl krew install node-shell
  kubectl krew install prompt
  kubectl krew install score
  kubectl krew install rbac-view
  kubectl krew install skew
  kubectl krew install view-secret
}

function change_to_zsh_shell() {
  sudo sed -i 's/\/bin\/bash/\/bin\/zsh/g' /etc/passwd
}

function install_tmux_config() {
  wget --quiet https://gist.githubusercontent.com/friedrich-brunzema/4bc098cd5d399c1ddf4add856bf1dde4/raw/2cf6fa256b14ef6f3045af664125838bf1c81c70/.tmux.conf -O ~/.tmux.conf
}

function install_oh_my_zsh() {
  wget --quiet https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
  git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/plugins/zsh-z
  git clone https://github.com/superbrothers/zsh-kubectl-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-kubectl-prompt
}

function install_vim_pathogen() {
  mkdir -p ~/.vim/autoload ~/.vim/bundle
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
}

function install_docker_in_docker() {
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
}

function fixup_locales() {
  echo "en_US.UTF-8 UTF-8" | sudo tee /etc/locale.gen
  sudo locale-gen
}

function install_argo_cli() {
  cd /tmp
  curl -sLO https://github.com/argoproj/argo-workflows/releases/download/$ARGO_CLI/argo-linux-amd64.gz
  gunzip argo-linux-amd64.gz
  chmod +x argo-linux-amd64
  sudo mv ./argo-linux-amd64 /usr/local/bin/argo
  cd $OLDPWD
}

function install_argo_cd_cli() {
  sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$ARGO_CD_CLI/argocd-linux-amd64
  sudo chmod +x /usr/local/bin/argocd
}

function install_latest_kustomize_cli() {
  cd /tmp
  curl -sSL -o /tmp/install_kustomize.sh "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" 
  bash install_kustomize.sh $KUSTOMIZE
  sudo mv ./kustomize /usr/local/bin/kustomize
  cd $OLDPWD
}

function install_redis_cli() {
  pushd .
  wget --quiet https://download.redis.io/releases/redis-$REDIS_CLI.tar.gz
  tar -xzvf redis-$REDIS_CLI.tar.gz
  cd redis-$REDIS_CLI
  sudo make install
  cd ./src
  sudo mv ./redis-cli /usr/local/bin/redis-cli
  popd
}

function install_solr_post() {
  cd /tmp
  sudo apt-get update
  sudo apt install -y openjdk-11-jre
  wget -q https://dlcdn.apache.org/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz
  tar -xzvf solr-$SOLR_VERSION.tgz
  cd solr-$SOLR_VERSION/bin
  sudo mv post /usr/local/bin/post
  cd $OLDPWD
}

function install_kubescape() {
  sudo curl -fsSL -o /usr/local/bin/kubescape https://github.com/armosec/kubescape/releases/download/$KUBESCAPE/kubescape-ubuntu-latest
  sudo chmod +x /usr/local/bin/kubescape
}

function install_eksctl() {
  sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/v$EKSCTL_VERSION/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp
  sudo mv /tmp/eksctl /usr/local/bin
}

function install_charttester() {
  sudo curl -fsSL --location "https://github.com/helm/chart-testing/releases/download/v3.5.0/chart-testing_3.5.0_linux_amd64.tar.gz" | tar xz -C /tmp
  chmod +x /tmp/ct
  sudo mv /tmp/ct /usr/local/bin/ct
}

function install_yq {
  sudo wget -q "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" \
          -O /usr/bin/yq 
  sudo chmod +x /usr/bin/yq
}

function install_exa {
  EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
  curl --silent -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
  sudo unzip -q exa.zip bin/exa -d /usr/local
}

function export_software_versions() {
  export TILLER_NAMESPACE=tiller
  export EKSCTL_VERSION=0.80.0
  export CT_VERSION='3.5.0'
  export HELM_VERSION=v2.14.2
  export KREW_VERSION=v0.4.2
  export KUBE_LATEST_VERSION=1.22.2
  export AWSCLI_VERSION=2.4.27
  export AWS_AUTH_VERSION=0.5.3
  export KEEP_ZSHRC=yes
  export SOPS_VERSION=3.7.2
  export TERRAFORM_VERSION=0.11.15
  export TERRAFORM_LATEST_VERSION=1.1.7
  export TERRAGRUNT_VERSION=v0.36.6
  export HELM3_VERSION=3.8.1
  export PACKER_VERSION=1.7.9
  export CLOUD_NUKE_VERSION=v0.11.3
  export ARGO_CD_CLI=v2.3.1
  export ARGO_CLI=v3.2.6
  export REDIS_CLI=6.2.6
  export SOLR_VERSION=8.11.1
  export KUSTOMIZE=4.5.2
  export KUBESCAPE=v2.0.149
  export YQ_VERSION='v4.23.1'
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  export LANGUAGE=en_US.UTF-8
}

function install_vscode_extensions() {
  code --install-extension 4ops.packer
  code --install-extension adamhartford.vscode-base64
  code --install-extension bibhasdn.unique-lines
  code --install-extension dotjoshjohnson.xml
  code --install-extension editorconfig.editorconfig
  code --install-extension euskadi31.json-pretty-printer
  code --install-extension fabiospampinato.vscode-open-in-terminal
  code --install-extension hashicorp.terraform
  code --install-extension mohsen1.prettify-json
  code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
  code --install-extension ms-python.python
  code --install-extension rafamel.subtle-brackets
  code --install-extension rebornix.ruby
  code --install-extension shaimendel.kubernetesapply
  code --install-extension slevesque.vscode-hexdump
  code --install-extension tht13.html-preview-vscode
  code --install-extension wmaurer.vscode-jumpy
  code --install-extension wwm.better-align
  code --install-extension yuichinukiyama.tabspacer
  code --install-extension eamodio.gitlens
  code --install-extension adamhartford.vscode-base64
  code --install-extension slevesque.vscode-hexdump
  code --install-extension redhat.vscode-yaml
  code --install-extension Tyriar.sort-lines
  code --install-extension ms-vscode-remote.remote-containers
  code --install-extension ms-vscode-remote.remote-ssh
  code --install-extension adamhartford.vscode-base64
}


function finish_up() {
  touch ~/.ssh/environment
  cp $HOME/git/ubuntu-20-devops-tools/.gitconfig ~/.gitconfig
  figlet "One-Time Setup for Git" -w 200
  printf "Enter user name (e.g. John Doe) for git: "
  read -r username
  printf "Enter user email for git: "
  read -r email
  sudo git config --global user.name "$username"
  sudo git config --global user.email "$email"
  cp $HOME/git/ubuntu-20-devops-tools/inspiration.zsh-theme $HOME/.oh-my-zsh/themes/inspiration.zsh-theme
  ssh-keygen -b 2048 -t rsa -f $HOME/.ssh/id_rsa -q
  chmod 600 ~/.ssh/id_rsa
}

function main() {
  export_software_versions
  install_base_packages
  fixup_locales
  install_git
  install_aws_cli
  install_kubectl
  install_helm
  install_terraform
  install_terragrunt
  install_aws_iam_authenticator
  install_cloud_nuke
  install_sops
  install_krew
  install_packer
  install_argo_cli
  install_argo_cd_cli
  install_latest_kustomize_cli
  install_redis_cli
  install_kubescape
  install_krew_plugins
  install_eksctl
  install_charttester
  install_yq
  install_solr_post
  change_to_zsh_shell
  install_oh_my_zsh
  install_vim_pathogen
  install_docker_in_docker
  install_exa
  install_vs_code_extensions

  finish_up
}

main

