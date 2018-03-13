FROM ubuntu
ARG user=demo
ARG password=demo
RUN apt-get update \
	&& apt-get install -y samba \
	&& useradd ${user} \
	&& echo ${user}:${password} | /usr/sbin/chpasswd \
	&& (echo ${password}; echo ${password}) | smbpasswd -a ${user} \
	&& echo "[External HDD]" >> /etc/samba/smb.conf \
	&& echo "	path = /storage" >> /etc/samba/smb.conf \
	&& echo "	writeable = yes" >> /etc/samba/smb.conf \
	&& echo ";	browseable = yes" >> /etc/samba/smb.conf \
	&& echo "	valid users = ${user}" >> /etc/samba/smb.conf
EXPOSE 443 
CMD service smbd start & service nmbd start & bash
