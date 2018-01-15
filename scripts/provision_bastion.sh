#!/bin/bash
if hash ansible-playbook 2>/dev/null; then
  echo "[INFO] Ansible is already installed, nothing to do here..." >&1
else
  echo "[INFO] Installing software-properties-common..." >&1
  apt-get -qq install software-properties-common -y >/dev/null
  echo "[INFO] Done" >&1
  echo "[INFO] Adding ansible repository..."
  apt-add-repository ppa:ansible/ansible >/dev/null
  echo "[INFO] Done" >&1
  echo "[INFO] Updating..."
  apt-get -qq update >/dev/null
  echo "[INFO] Done" >&1
  echo "[INFO] Installing ansible..."
  apt-get -qq install ansible  -y >/dev/null
  echo "[INFO] Done" >&1
fi

echo "[INFO] chmoding private key" >&1
chmod 600 /home/vagrant/.ssh/id_rsa

echo "[INFO] Installing ansible roles..." >&1
apt-get -qq install git  -y >/dev/null
su vagrant -c"ssh-keyscan git.itigo.tech > /home/vagrant/.ssh/known_hosts"
su vagrant -c"ssh-keyscan github.com >> /home/vagrant/.ssh/known_hosts"
su vagrant -c"ssh-keyscan gitlab.com >> /home/vagrant/.ssh/known_hosts"
su vagrant -c"ansible-galaxy install -fr /home/vagrant/ansible/provision/requirements.yml"
echo "[INFO] Done" >&1


echo "[INFO] Adding VM's to known_hosts" >&1
su vagrant -c"ssh-keyscan 192.168.200.10 >> /home/vagrant/.ssh/known_hosts"
su vagrant -c"ssh-keyscan 192.168.200.11 >> /home/vagrant/.ssh/known_hosts"
su vagrant -c"ssh-keyscan 192.168.200.21 >> /home/vagrant/.ssh/known_hosts"
su vagrant -c"ssh-keyscan 192.168.200.22 >> /home/vagrant/.ssh/known_hosts"
# if [ -f /etc/hosts.orig ]; then
#    cp /etc/hosts /etc/hosts.orig
# fi
# rm /etc/hosts
# cp /etc/hosts.orig /etc/hosts
# echo ""
