# On chroot

sudo rm /etc/init.d/resize2fs_once
sudo mkdir /wbc_tmp

#Required to load different firmware depending on WiFi or broadcast mode. Done inside /root/.profile
sudo rm -r /lib/firmware/ath9k_htc
sudo ln -s /tmp/ath9k_htc /lib/firmware/

#Configure Samba file server to run in RO mode.
sudo cp -R /var/lib/samba /var/lib/samba_real
sudo rm -rf /var/lib/samba
sudo ln -s /tmp/samba/lib-samba /var/lib/samba
sudo rm -r /var/cache/samba
sudo ln -s /tmp/samba/cache-samba /var/cache/samba
sudo rm -r /var/log/samba
sudo ln -s /tmp/samba/log-samba /var/log/samba
rm -rf /var/run/samba/
sudo ln -s /tmp/samba/run/samba /var/run/samba
sudo ln -s /tmp/samba/spool/samba /var/spool/samba

#configure SSH permissions copied from overlay dir
sudo chmod 644 /etc/ssh/moduli
sudo chmod 644 /etc/ssh/ssh_config
sudo chmod 644 /etc/ssh/sshd_config
sudo chmod 600 /etc/ssh/ssh_host_dsa_key
sudo chmod 644 /etc/ssh/ssh_host_dsa_key.pub
sudo chmod 600 /etc/ssh/ssh_host_ecdsa_key
sudo chmod 644 /etc/ssh/ssh_host_ecdsa_key.pub
sudo chmod 600 /etc/ssh/ssh_host_ed25519_key
sudo chmod 644 /etc/ssh/ssh_host_ed25519_key.pub
sudo chmod 600 /etc/ssh/ssh_host_rsa_key
sudo chmod 644 /etc/ssh/ssh_host_rsa_key.pub
sudo chmod 644 /etc/ssh/ssh_import_id

# Make fifos
sudo mkfifo /root/videofifo1
sudo mkfifo /root/videofifo2
sudo mkfifo /root/videofifo3
sudo mkfifo /root/videofifo4
sudo mkfifo /root/telemetryfifo1
sudo mkfifo /root/telemetryfifo2
sudo mkfifo /root/telemetryfifo3
sudo mkfifo /root/telemetryfifo4
sudo mkfifo /root/telemetryfifo5
sudo mkfifo /root/telemetryfifo6
sudo mkfifo /root/mspfifo

# Enable gpio service
sudo systemctl enable wbcconfig.service
sudo systemctl start wbcconfig.service


# Copy tty autologin stuff
cd /etc/systemd/system/getty.target.wants
sudo cp getty@tty1.service getty@tty2.service
sudo cp getty@tty1.service getty@tty3.service
sudo cp getty@tty1.service getty@tty4.service
sudo cp getty@tty1.service getty@tty5.service
sudo cp getty@tty1.service getty@tty6.service
sudo cp getty@tty1.service getty@tty7.service
sudo cp getty@tty1.service getty@tty8.service
sudo cp getty@tty1.service getty@tty9.service
sudo cp getty@tty1.service getty@tty10.service
sudo cp getty@tty1.service getty@tty11.service
sudo cp getty@tty1.service getty@tty12.service

# Make files executable
cd /etc/init.d/
sudo chmod +x raspi-config 
cd
cd /root/wifibroadcast_misc/
sudo chmod +x gpio-config.py
sudo chmod +x wbcconfig.sh

#enable txpower from command line and RemoteSettings app
sudo chmod 755 /usr/local/bin/txpower_atheros
sudo chmod 755 /usr/local/bin/txpower_ralink

#disable sync option for usbmount
sudo sed -i 's/sync,//g' /etc/usbmount/usbmount.conf

#change hostname
CURRENT_HOSTNAME=`sudo cat /etc/hostname | sudo tr -d " \t\n\r"`
NEW_HOSTNAME="wbc"
if [ $? -eq 0 ]; then
  sudo sh -c "echo '$NEW_HOSTNAME' > /etc/hostname"
  sudo sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
fi

