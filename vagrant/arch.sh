#!/bin/bash

set -ex

### Install dependencies
yes | pacman -Syu
yes | pacman -S python2
