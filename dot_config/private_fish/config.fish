# Paths
fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin
fish_add_path ~/.krew/bin

fish_config theme choose "Catppuccin Mocha"

set -x HOMEBREW_NO_AUTO_UPDATE 1

# Golang config
set -x GOPATH (go env GOPATH)
set -x PATH $PATH (go env GOPATH)/bin
set -x GO111MODULE on
go env -w GOPRIVATE=github.com/Arm-Debug


# Tokens
# security add-generic-password -a "$USER" -s 'name_of_your_key' -w 'passphrase'
set -x GITHUB_TOKEN $(security find-generic-password -a "$USER" -s "GITHUB_TOKEN" -w)
set -x CIRCLECI_TOKEN $(security find-generic-password -a "$USER" -s "CIRCLECI_TOKEN" -w)


# Artifactory credentials
set -x ARTIFACTORY_HOST "https://artifactory.core.test.mbed.com"
set -x ARTIFACTORY_USER "sam.hogg%40arm.com"
set -x ARTIFACTORY_PASSWORD $(security find-generic-password -a "$USER" -s "ARTIFACTORY_PASSWORD" -w)
set -x QA_ARTIFACTORY_TOKEN $(security find-generic-password -a "$USER" -s "QA_ARTIFACTORY_TOKEN" -w)
set -x PROD_ARTIFACTORY_TOKEN $(security find-generic-password -a "$USER" -s "PROD_ARTIFACTORY_TOKEN" -w)

# AWS
set -x AWS_DEFAULT_PROFILE otg-qa
# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'


# Enable BuildKit everywhere
set -x DOCKER_BUILDKIT 1
set -x COMPOSE_DOCKER_CLI_BUILD 1


kubectl completion fish | source


# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish
set -x ASDF_GOLANG_MOD_VERSION_ENABLED true

# kubeswitch
switcher init fish | source

# zoxide
zoxide init fish | source

# iterm2
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# abbr
abbr -a -- awssso 'aws sso login --sso-session arm'
abbr -a -- tf terraform
abbr -a -- goland 'open -a goland'
abbr -a -- awswhoami 'aws sts get-caller-identity'
abbr -a -- kcg 'kubectl get'
abbr -a -- kcgn 'kubectl get nodes --label-columns=node.kubernetes.io/role --label-columns node.kubernetes.io/gvisor --label-columns topology.kubernetes.io/zone'
abbr -a -- reload 'source ~/.config/fish/config.fish'
abbr -a -- kcl 'kubectl logs'
abbr -a -- ksn 'kubeswitch ns'
abbr -a -- dc docker-compose
abbr -a -- kcd 'kubectl describe'
abbr -a -- tree 'exa -T'
abbr -a -- ks kubeswitch
abbr -a -- textmate 'open -a textmate'
abbr -a -- kc kubectl
abbr -a -- kcrun 'kubectl run ubuntu-s -it --wait --attach --rm=true --restart=Never --image=ubuntu:20.04 -- bash'
abbr -a -- asso 'aws sso login --sso-session arm'



