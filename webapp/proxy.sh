#!/bin/sh
ssh -o ServerAliveInterval=30 -o TCPKeepAlive=yes -o StrictHostKeyChecking=no -R sempak.serveo.net:80:0.0.0.0:8081 serveo.net