#!/bin/bash

echo "[INFO] adding bastion key." >&1
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chown vagrant /home/vagrant/.ssh/authorized_keys

echo "[INFO] mounting brick volume" >&1
parted /dev/sdb mklabel msdos
parted /dev/sdb mkpart primary 512 100%
mkfs.xfs /dev/sdb1
mkdir -p /data/glusterfs/vagrantvol/brick1
echo `blkid /dev/sdb1 | awk '{print$2}' | sed -e 's/"//g'` /data/glusterfs/vagrantvol/brick1   xfs   noatime,nobarrier   0   0 >> /etc/fstab
mount /data/glusterfs/vagrantvol/brick1

# if hash ansible-playbook 2>/dev/null; then
#   echo "[INFO] Ansible is already installed, nothing to do here..." >&1
# else
#   echo "[INFO] Installing software-properties-common..." >&1
#   apt-get -qq install software-properties-common -y >/dev/null
#   echo "[INFO] Done" >&1
#   echo "[INFO] Adding ansible repository..."
#   apt-add-repository ppa:ansible/ansible >/dev/null
#   echo "[INFO] Done" >&1
#   echo "[INFO] Updating..."
#   apt-get -qq update >/dev/null
#   echo "[INFO] Done" >&1
#   echo "[INFO] Installing ansible..."
#   apt-get -qq install ansible  -y >/dev/null
#   echo "[INFO] Done" >&1
# fi
#
# echo "[INFO] Installing ansible roles..." >&1
# apt-get -qq install git  -y >/dev/null
# ssh-keyscan git.itigo.tech > /home/vagrant/.ssh/known_hosts
# ssh-keyscan github.com >> /home/vagrant/.ssh/known_hosts
# ssh-keyscan gitlab.com >> /home/vagrant/.ssh/known_hosts
# su vagrant -c"ansible-galaxy install -fr /home/vagrant/ansible/provision/requirements.yml"
# echo "[INFO] Done" >&1
# su vagrant -c"ansible-playbook -i /home/vagrant/ansible/provision/hosts -v /home/vagrant/ansible/provision/provision.yml"
