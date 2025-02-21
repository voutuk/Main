[jenkins]
${join("\n", [for i in instances : "${i.name} ansible_host=${i.public_ip}" if i.type == "main"])}

[test]
${join("\n", [for i in instances : "${i.name} ansible_host=${i.public_ip}" if i.type == "test"])}

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_rsa