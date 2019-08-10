---
layout: post
title:  "Installing Parrallels Tools on Parrot OS"
date:   2019-08-10 16:18:03 -0500
categories: virtualization,infosec,parrot
---

I stumbled across [Parrot OS](https://www.parrotsec.org) while researching a few infosec topics and decided to try it out. Installing Parallels Tools on Parrot isn't very straight forward.

Parallels has a knowledge base article on [how to install Tools on Kali Linux](https://kb.parallels.com/en/123968) that I used as a guide for this.

If you're starting fresh with Parrot, it's a good idea to take regular snapshots along the way in case you need to back anything out.

Here are the steps I tool to install Parallels Tools and the required dependencies.

```sh
# Add the Kali source
sudo vi /etc/apt/sources.list
# Add the following line
deb https://http.kali.org/kali kali-rolling main non-free contrib

# Add the Kali GPG key
wget -q -O - https://archive.kali.org/archive-key.asc | apt-key add

# Install packages for Parallels Tools
sudo apt-get update
sudo apt-get install checkpolicy libelf-dev printer-driver-postscript-hp

# Once this completes, install Parallels Tools and remove the line you added to /etc/apt/sources.list
```