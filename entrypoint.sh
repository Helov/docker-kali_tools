#!/bin/bash
/bin/echo "root:toor" | chpasswd;
/usr/sbin/sshd -D;
