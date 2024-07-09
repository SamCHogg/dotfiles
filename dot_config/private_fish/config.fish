# Paths
fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin
fish_add_path ~/.krew/bin

# ASDF
fish_add_path "$ASDF_DIR/bin"
fish_add_path "$HOME/.asdf/shims"

if status --is-interactive && type -q asdf
    source (brew --prefix asdf)/libexec/asdf.fish
end


fish_config theme choose "Catppuccin Mocha"
set -g fish_greeting
set -g fish_key_bindings fish_default_key_bindings


set -x HOMEBREW_NO_AUTO_UPDATE 1

# Golang config
if type -q go
    set -x GOPATH ~/go/
    fish_add_path ~/go/bin
    set -x GO111MODULE on
    set -x GOPRIVATE github.com/Arm-Debug
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

# DockerHub
set -x DOCKERHUB_TOKEN "op://Work/Docker/PAT"

# AWS
if type -q aws
    set -x AWS_DEFAULT_PROFILE otg-qa

    abbr -a -- awssso 'aws sso login --sso-session arm'
    abbr -a -- asso 'aws sso login --sso-session arm'
    abbr -a -- awswhoami 'aws sts get-caller-identity'

    # Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
end

if type -q gh
    abbr -a -- gh 'op run -- gh'
end

# kubeswitch
#if type -q switcher and false
#    switcher init fish | source
#end

# zoxide
if type -q zoxide
    zoxide init fish | source
    if status is-interactive
        abbr -a -- cd z
    end
end


if type -q kubectl
    set -x KUBE_EDITOR nvim
    abbr -a -- kcg 'kubectl get'
    abbr -a -- kcgn 'kubectl get nodes --label-columns=node.kubernetes.io/role --label-columns node.kubernetes.io/gvisor --label-columns topology.kubernetes.io/zone'
    abbr -a -- kcl 'kubectl logs'
    abbr -a -- kcd 'kubectl describe'
    abbr -a -- kc kubectl
    abbr -a -- kcrun 'kubectl run ubuntu-s -it --wait --attach --rm=true --restart=Never --image=ubuntu:20.04 -- bash'
end

if type -q terraform
    abbr -a -- tf terraform
end

if type -q docker
    # Enable BuildKit everywhere
    set -x DOCKER_BUILDKIT 1
end

if type -q docker-compose
    # Enable BuildKit everywhere
    set -x COMPOSE_DOCKER_CLI_BUILD 1
    abbr -a -- dc docker-compose
end


# iterm2
#test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

# abbr
abbr -a -- goland 'open -a goland'
abbr -a -- reload 'source ~/.config/fish/config.fish'
abbr -a -- textmate 'open -a textmate'
