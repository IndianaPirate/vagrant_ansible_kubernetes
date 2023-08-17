echo "[+] Update repos"
apt update -y 
echo "[+] Install ansible"
apt install ansible -y 
echo "[+] Install git"
apt install git -y
echo "[+] Fix broken install"
apt --fix-broken install -y
echo "Active l'authentification par mot de passe"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

echo "Mettre le mot de passe root"
echo -e "kubeadmin\nkubeadmin" | passwd root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bash.bashrc

echo "[+] Clone repository"
git clone https://github.com/IndianaPirate/vagrant_ansible_kubernetes.git
cd vagrant_ansible_kubernetes
echo "[+] Ansible Galaxy"
ansible-galaxy -i inventory playbook_node.yml
