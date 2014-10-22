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
  ansible-playbook -vvvv ansible/setup.yml --extra-vars "@vars.yml" --extra-vars display=$DISPLAY -i ansible/hosts
}

launch
