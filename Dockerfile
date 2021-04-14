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
apt-get install -y python sqlmap nmap metasploit-framework vim openjdk-11-jdk openssh-server ruby

# update sshd config
RUN set -eux; \
mkdir /var/run/sshd; \
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config; \
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config; \
echo "UsePAM no" >> /etc/ssh/sshd_config

WORKDIR data

EXPOSE 22

ENTRYPOINT ["sshd"]
CMD ["-D"]
