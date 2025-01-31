chmod 600 azure_rsa
az vm show -d -g dev-environment-rg -n dev-vm --query "publicIps" -o tsv

sudo docker run -ti --rm \
    -v $(pwd):/apps \
    -w /apps \
    alpine/ansible \
    ansible-playbook vm-main.yml -i "52.169.73.162," --private-key=/apps/azure_rsa -u ubuntu --extra-vars "@vars.yml"


sudo docker run -ti --rm \
    -v $(pwd):/apps \
    -w /apps \
    alpine/ansible \
    ansible-playbook jen-slave.yml -i "89.168.87.17," --private-key=/apps/oracle_rsa -u ubuntu --extra-vars "@vars.yml"


sudo docker run -ti --rm \
    -v $(pwd):/apps \
    -w /apps \
    alpine/ansible \
    ansible-playbook jen-setup.yml -i "52.236.39.49," --private-key=/apps/azure_rsa -u ubuntu --extra-vars "@vars.yml"


sudo docker run -ti --rm \                
    -v $(pwd):/apps \
    -w /apps \
    alpine/ansible \
    ansible-playbook jen-slave.yml -i "20.13.128.144," --private-key=/apps/azure_rsa -u azureuser --extra-vars "@vars.yml"
