#!/bin/bash
/bin/echo "root:$@" | chpasswd;
/usr/sbin/sshd -D;
