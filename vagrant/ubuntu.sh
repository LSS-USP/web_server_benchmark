#!/bin/bash

set -ex

### Install dependencies
apt-get update

apt-get install curl git unzip build-essential gettext libxml2-dev libxslt1-dev libssl-dev libffi-dev -y

### Acceptance Tests dependencies
apt-get install xvfb firefox -y
