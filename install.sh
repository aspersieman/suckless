#!/bin/bash

set -e

cd chadwm
./install.sh
cd -

cd st
./install.sh
cd -

cd surf
./install.sh
cd -

cd slock
./install.sh
cd -
