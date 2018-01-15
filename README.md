# docker-kubernetes

Collection of helper scripts for using Kubernetes from Docker.

## Getting started

To install the necessary Docker version, use:

    ```sh
    ./dokube install
    ```

## Usage

```sh
./dokube [OPTION]

Options:
    install                 Install the Docker prerequisites
    dash                    Install and launch the Kubernetes dashboard
    set-context             Set the K8s context to be Docker
    context                 View the current context
    info                    View the current cluster info
    nodes                   Get the current node information
```