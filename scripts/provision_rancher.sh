#!/bin/bash

echo "[INFO] adding bastion key." >&1
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chown vagrant /home/vagrant/.ssh/authorized_keys

