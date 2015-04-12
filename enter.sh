#!/bin/bash
docker exec -ti developer_base_image_instance script -q -c "/sbin/setuser developer /bin/bash -c 'cd ~ && /bin/bash'" /dev/null
