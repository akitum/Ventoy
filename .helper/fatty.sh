#!/bin/bash

set -eu

COMMAND="${1:-none}"
TAG="${2:-latest}"

function print_help() {
  printf "\
fatty is a docker image containing all deps required for ventoy in-tree-builds \
(please note that it is at the moment not possible in rootless-mode)

usage: fatty.sh <command> <tag>

command
    build      build fatty
    run        run fatty interactively

               from inside the container you can e.g. run:
               cd /ventoy
               .helper/prepare_tree.sh
               INSTALL/all_in_one.sh CI

tag
    specify the image tag to use for fatty
    defaults to: 'latest'
"
}

case "$(pwd)" in
    */.helper)
        context="$(cd .. ; pwd)"
        ;;
    *)
        context="$(pwd)"
        ;;
esac

case "${COMMAND}" in
    "--help")
        print_help
        ;;
    build)
        echo "context dir: ${context}"
        sudo docker build \
        --tag ventoy:"${TAG}" \
        --file .helper/fatty.dockerfile \
        "${context}"
        ;;
    run)
        echo "context dir: ${context}"
        sudo docker run \
        --privileged \
        --rm \
        --mount type=bind,source="${context}",target="/ventoy" \
        -v /dev:/dev \
        -it \
        ventoy:"${TAG}"
        ;;
    *)
        echo "unknown command: '${COMMAND}'. see: fatty.sh --help"  
        exit 1
        ;;
esac
