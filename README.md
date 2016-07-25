# What is web server benchmark?

> The main idea of this repository, it is to keep an automated benchmark for
web servers (specially Apache httpd). I have seen thousands of benchmarks
comparing a lot of things related to the web server with a bunch  amazing
results. However, many of those benchmarks do not have a clear specification.
For example, many people do not make clear what kind of settings they used.

# Usage

## Running it inside virtual machines

> To make easy to reproduce this benchmark, we have the option to run it inside
a virtual machine. This setting relies in some softwares, that you have to
install. First of all, you have to install:

* Virtualbox 5
* Rake 11.1
* Vagrant 1.8
* Ansible 2.1

> If you not have a public key, generate an SSH key. Copy your id_rsa.pub
inside the /vagrant folder.

```
cp ~/.ssh/id_rsa.pub /vagrant
```

> The next step, it is turn on the virtual machine. Just type:

```
rake vms:start arch
```

## Deploy the benchmark

> After you did the basic setup (a machine or virtual machine), it is time to
configure your host:


```
ansible-playbook -i hosts benchmark.yml
```
