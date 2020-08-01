#!/bin/sh
# SSG agent: remembers SSH key passwords
# PSD: firefox in RAM
for service in ssh-agent.serice psd.service; do
    systemctl --user enable $service
    systemctl --user star $service
done
