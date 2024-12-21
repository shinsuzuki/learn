#!/bin/bash

sed -n '/systemd/ s/usr/********/gp' /etc/passwd
