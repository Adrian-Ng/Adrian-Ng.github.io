---
layout: single
title: "adrian.ng"
permalink: /notes/packages/
toc: true
excerpt: because I can't remember how to install anything on Ubuntu
---

```bash
sudo apt update && sudo apt upgrade
```

## install xorg

```bash
sudo apt-get install xauth
sudo apt-get install xorg openbox
```
## install VS code

[Reference](https://code.visualstudio.com/docs/setup/linux)

The repository and key can also be installed manually with the following script:

```bash
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
```
Then update the package cache and install the package using:
```bash
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code
```
This also needs to be installed:
```bash
sudo apt-get install libasound2
```

To run _code_:

```bash
#normally
code

#if nothing happens
code --verbose

# if x11 doesn't like your GPU
code --disable-gpu
```
# TeX

```bash
sudo apt-get install texlive-full
```
Then i use _VS Code_ as my `TeX` editor.