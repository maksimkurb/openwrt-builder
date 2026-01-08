#!/bin/bash

set -e

# Add other package compilation instructions below
make -j$(nproc) V=s package/cups/compile
