#!/bin/bash

echo "PASSO 01 - DESATIVAR O FIREWALL"
systemctl disable --now ufw >/dev/null 2>&1

echo "PASSO 02 - HABILITAR A AUTENTICAÇÃO COM SSH"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

echo "PASSO 03 - DEFINIR A SENHA DO ROOT"
echo -e "kubeadmin\nkubeadmin" | passwd root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bash.bashrc

echo "PASSO 04 - ALTERAR O ARQUIVO /etc/hosts"
cat >>/etc/hosts<<EOF
172.16.16.100   k8s-control.labs.com.br     k8s-control
172.16.16.101   k8s-node1.labs.com.br       k8s-node1
172.16.16.102   k8s-node2.labs.com.br       k8s-node1
EOF