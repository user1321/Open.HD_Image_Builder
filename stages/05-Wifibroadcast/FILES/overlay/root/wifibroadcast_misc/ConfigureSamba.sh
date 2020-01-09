mkdir /tmp/samba
mkdir /tmp/samba/run/
mkdir /tmp/samba/run/samba
mkdir /tmp/samba/spool
mkdir /tmp/samba/spool/samba
mkdir /tmp/samba/lib-samba/private

cp -R /var/lib/samba_real /tmp/samba/lib-samba
mkdir /tmp/samba/cache-samba
mkdir /tmp/samba/log-samba
sudo ln -s /tmp/samba/log-samba /var/log/samba
