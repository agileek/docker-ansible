#!/bin/bash
set -e

RUN_DIR=$(dirname $(readlink -f "$0"))

cd "$RUN_DIR"

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

check_usage_min_max $# 1 1 "USAGE ./launch.sh path_to_save_developer_home_folder (eg: ./launch.sh ~/myDeveloperHomeInDocker)"
function launch() {
  local path_to_save_docker_home_folder="${1}"
  ansible-playbook -vvvv ansible/setup.yml --extra-vars "@vars.yml" --extra-vars "path_to_save_docker_home_folder=${path_to_save_docker_home_folder} display=$DISPLAY" -i ansible/hosts
}

launch "${1}"
