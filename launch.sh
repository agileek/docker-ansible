#!/bin/bash
set -e

function check_usage_min_max() {
        argc=${1}
        min_expected=${2}
        max_expected=${3}
        usage=${4}

        if [[ ${argc} -lt ${min_expected} ]] || [[ ${argc} -gt ${max_expected} ]]; then
                echo -e ${usage}
                exit 1
        fi
}

function launch() {
  docker run -dti -e DISPLAY -p 22 --name "developer_base_image_instance" -v /tmp/.X11-unix:/tmp/.X11-unix developer_base_image
  local ssh_port=`docker port developer_base_image_instance | grep 22 | sed 's/.*:\([0-9]*\)$/\1/'`

  ansible-playbook ansible/setup.yml -i ansible/hosts --extra-vars ansible_ssh_port="${ssh_port}"
}

launch
