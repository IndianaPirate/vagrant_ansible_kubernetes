echo "Active l'authentification par mot de passe"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

echo "Mettre le mot de passe root"
echo -e "kubeadmin\nkubeadmin" | passwd root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bash.bashrc

apt update -y 
apt install ansible -y
apt install git -y
git clone https://github.com/IndianaPirate/vagrant_ansible_kubernetes.git
cd vagrant_ansible_kubernetes
ansible-galaxy playbook_node.yml
