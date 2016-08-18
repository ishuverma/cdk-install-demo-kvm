#!/bin/sh

echo "Login as root to perform the following steps"

su
subscription-manager repos --enable rhel-server-rhscl-7-rpms
subscription-manager repos --enable rhel-7-server-optional-rpms
yum-config-manager --add-repo=http://mirror.centos.org/centos-7/7/sclo/x86_64/sclo/
echo "gpgcheck=0" >> /etc/yum.repos.d/mirror.centos.org_centos-7_7_sclo_x86_64_sclo_.repo


yum groupinstall "Virtualization Host"
systemctl start libvirtd
systemctl enable libvirtd

# Installing Vagrant, required packages and libvirt-plugin

echo "Installing Vagrant, required packages and libvirt-plugin"

yum install sclo-vagrant1 sclo-vagrant1-vagrant-libvirt sclo-vagrant1-vagrant-libvirt-doc
yum downgrade sclo-vagrant1-vagrant-1.7.4

cp /opt/rh/sclo-vagrant1/root/usr/share/vagrant/gems/doc/vagrant-libvirt-*/polkit/10-vagrant-libvirt.rules /etc/polkit-1/rules.d

# Restart libvirt and Policykit
echo "Restarting libvirt and Policykit"

systemctl restart libvirtd
systemctl restart polkit

# echo "The End"
