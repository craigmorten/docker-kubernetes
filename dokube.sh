#!/bin/bash

DOCKER_PACKAGE_URL="https://download.docker.com/mac/edge"

cmd=$1
if [ $# -eq 0 ]; then
    echo "Insufficient args."
    exit 1
fi

# TODO: cross OS support?
# TODO: can we control the start and stop without the GUI, otherwise what's the point? :P

case ${cmd} in
install)
    set -x
    tempd=$(mktemp -d)
    curl -o ${tempd}/Docker.dmg ${DOCKER_PACKAGE_URL}/Docker.dmg
    sudo hdiutil attach ${tempd}/Docker.dmg
    sudo cp -rf /Volumes/Docker/*.app /Applications
    sudo hdiutil detach /Volumes/Docker
    rm -rf $tempd
    set +x
    open /Applications/Docker.app
    # TODO: can we automate this setup?
    echo "Please follow the Docker installation instructions..."
    echo "Once installed, head to Docker -> Preferences -> Kubernetes."
    echo "Check the 'Enable Kubernetes' box, and click apply."
    echo "Once complete, a message of 'Kuberenetes successfully installed' will appear."
    ;;
dash)
    # TODO: check if already created?
    kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
    podname=$(kubectl get pods --no-headers —-namespace=kube-system | grep kubernetes-dashboard | awk '{ print $1 }')
    kubectl port-forward ${podname} 8443:8443 —-namespace=kube-system &
    echo "Open https://localhost:8443 to view the dashboard"
    ;;
rm-dash)
    # TODO: find the dashboard port-forward process and kill it
    ;;
set-context)
    kubectl config use-context docker-for-desktop
    ;;
context)
    kubectl config current-context
    ;;
info)
    kubectl cluster-info
nodes)
    kubectl get nodes
    ;;
esac

