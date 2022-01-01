FROM kalilinux/kali-rolling

MAINTAINER "Helov"

# add aliyun mirror
RUN set -eux; \
printf 'deb http://mirrors.cloud.aliyuncs.com/kali/ kali-rolling main non-free contrib\n\
deb-src http://mirrors.cloud.aliyuncs.com/kali/ kali-rolling main non-free contrib\n\
deb http://mirrors.aliyun.com/kali/ kali-rolling main non-free contrib\n\
deb-src http://mirrors.aliyun.com/kali/ kali-rolling main non-free contrib' >> /etc/apt/sources.list; \
apt-get update

# add base tools
RUN set -eux; \
apt-get install -y python2 sqlmap nmap metasploit-framework vim openjdk-17-jdk openssh-server ruby

# update sshd config
RUN set -eux; \
mkdir /var/run/sshd; \
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config; \
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config; \
echo "UsePAM no" >> /etc/ssh/sshd_config

WORKDIR data

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd"]
CMD ["-d"]
