# What is web server benchmark?

> The main idea of this repository, it is to keep an automated benchmark for
web servers (specially Apache httpd). I have seen thousands of benchmark
comparing things related to web server with many amazing results. However, many
of those benchmark do not have a clear specification. For example, many people
do not say anything about the hardware that they run or which kind of settings
it was used.

# Usage

## Running it inside virtual machines

> First of all, you have to install:

* Virtualbox
* Rake
* Vagrant

> If you not have a public key, generate an SSH key. Copy your id_rsa.pub
inside the /vagrant folder.

```
cp ~/.ssh/id_rsa.pub /vagrant
```

> The next step, it is turn on the virtual machine. Just type:

```
rake vms:start arch
```

