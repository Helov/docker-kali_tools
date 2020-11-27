FROM kalilinux/kali-rolling

MAINTAINER "hello hello@vvaii.com"

# replace aliyun mirror
RUN set -eux; \
printf 'deb http://mirrors.cloud.aliyuncs.com/kali/ kali-rolling main non-free contrib\n\
deb-src http://mirrors.cloud.aliyuncs.com/kali/ kali-rolling main non-free contrib\n\
deb http://mirrors.aliyun.com/kali/ kali-rolling main non-free contrib\n\
deb-src http://mirrors.aliyun.com/kali/ kali-rolling main non-free contrib' >> /etc/apt/sources.list; \
apt-get update

# init
RUN set -eux; \
apt-get update; \
apt-get install -y python sqlmap nmap metasploit-framework openjdk-8-jdk vim openssh-server ruby; \
mkdir /var/run/sshd; \
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config; \
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config; \
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

WORKDIR kali-docker

ADD entrypoint.sh /kali-docker/entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/kali-docker/entrypoint.sh"]
