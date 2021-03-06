#!/usr/bin/env bash

# Run as root.

sh -c 'echo deb https://apt.buildkite.com/buildkite-agent stable main > /etc/apt/sources.list.d/buildkite-agent.list'
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 32A37959C2FA5C3C99EFBC32A79206696452D198
apt-get update && sudo apt-get install -y buildkite-agent
sed -i "s/xxx/${BUILDKITE_TOKEN}/g" /etc/buildkite-agent/buildkite-agent.cfg

systemctl enable buildkite-agent && sudo systemctl start buildkite-agent

usermod -a -G docker buildkite-agent

# Install docker

apt-get install     apt-transport-https     ca-certificates     curl     gnupg-agent     software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"


apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

# Istio-related tools
apt-get -qqy install make git tmux
curl -Lo - https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz | tar -C /usr/local -xzf -

