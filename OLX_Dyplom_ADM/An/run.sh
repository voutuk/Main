chmod 600 azure_rsa

# Run main inst installation
MSYS_NO_PATHCONV=1 docker run -ti --rm \
    -v "$(pwd)":/apps \
    -w /apps \
    alpine/ansible \
    /bin/sh -c "chmod 600 azure_rsa && ansible-playbook main-inst.yml -i hosts --extra-vars '@vars.yml' -e ansible_host_key_checking=False"

# Run jenkins save backup
MSYS_NO_PATHCONV=1 docker run -ti --rm \
    -v "$(pwd)":/apps \
    -w /apps \
    alpine/ansible \
    /bin/sh -c "chmod 600 azure_rsa && ansible-playbook jenkins-save.yml -i hosts --extra-vars '@vars.yml' -e ansible_host_key_checking=False"

# Run build inst installation
MSYS_NO_PATHCONV=1 docker run -ti --rm \
    -v "$(pwd)":/apps \
    -w /apps \
    alpine/ansible \
    /bin/sh -c "chmod 600 azure_rsa && ansible-playbook build-inst.yml -i hosts --extra-vars '@vars.yml' -e ansible_host_key_checking=False"

