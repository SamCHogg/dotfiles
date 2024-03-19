# Paths
fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin
fish_add_path ~/.krew/bin

fish_config theme choose "Catppuccin Mocha"

set -x HOMEBREW_NO_AUTO_UPDATE 1

# Golang config
if type -q go
  set -x GOPATH (go env GOPATH)
  set -x PATH $PATH (go env GOPATH)/bin
  set -x GO111MODULE on
  go env -w GOPRIVATE=github.com/Arm-Debug
end

# GitHub
set -x GITHUB_TOKEN "op://Personal/jamwb7mfjgrznc4xadxv6y5c5y/PATs/Work Laptop 3"

# CircleCI
set -x CIRCLECI_TOKEN "op://Personal/CircleCI/PATs/PAT"

# Artifactory
set -x ARTIFACTORY_QA_HOST "op://Work/Artifactory QA/url"
set -x ARTIFACTORY_QA_TOKEN "op://Work/Artifactory QA/PATs/PAT"
set -x ARTIFACTORY_PROD_HOST "op://Work/Artifactory PROD/url"
set -x ARTIFACTORY_PROD_TOKEN "op://Work/Artifactory PROD/PATs/PAT"

# AWS
if type -q aws
  set -x AWS_DEFAULT_PROFILE otg-qa
  
  abbr -a -- awssso 'aws sso login --sso-session arm'
  abbr -a -- asso 'aws sso login --sso-session arm'
  abbr -a -- awswhoami 'aws sts get-caller-identity'
  
  # Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
  complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
end


# Enable BuildKit everywhere
set -x DOCKER_BUILDKIT 1
set -x COMPOSE_DOCKER_CLI_BUILD 1

if type -q kubectl
  kubectl completion fish | source
end

# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish
set -x ASDF_GOLANG_MOD_VERSION_ENABLED true

# kubeswitch
if type -q switcher
  switcher init fish | source
end

# zoxide
if type -q zoxide
  zoxide init fish | source
end

# iterm2
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# abbr
abbr -a -- tf terraform
abbr -a -- goland 'open -a goland'
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



