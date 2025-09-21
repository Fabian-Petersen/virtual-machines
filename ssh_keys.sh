#!/bin/bash
# This file moves the ssh key from the external drive to internal storage on Macbook for a specific VM
# and creates a symlink back to the original location so Vagrant can still find it.
# Run this script after vagrant up to ensure keys are moved and linked properly.

set -e

# VM name
VMNAME="ubuntu_docker_jenkins"

# External project path (update this for your setup)

EXTERNAL_BASE="/Volumes/ExternalSSD/virtual_machines/$VMNAME/.vagrant/machines/docker-jenkins/vmware_desktop"
# Internal storage on Macbook for private keys
INTERNAL_BASE="$HOME/Desktop/vms/vm_private_keys/$VMNAME"

# Ensure internal VM-specific directory exists
mkdir -p "$INTERNAL_BASE"

# Path to the private key
KEYFILE="$EXTERNAL_BASE/private_key"

if [ -f "$KEYFILE" ]; then
    # Move the private key if not already moved
    if [ ! -f "$INTERNAL_BASE/private_key" ]; then
        echo "Moving key for $VMNAME..."
        mv "$KEYFILE" "$INTERNAL_BASE/private_key"
    else
        echo "Key for $VMNAME already exists internally, skipping move."
    fi

    # Remove any existing file or symlink at the original path
    rm -f "$KEYFILE"

    # Create symlink
    echo "Linking $KEYFILE -> $INTERNAL_BASE/private_key"
    ln -s "$INTERNAL_BASE/private_key" "$KEYFILE"

    # Fix permissions
    chmod 600 "$INTERNAL_BASE/private_key"

    echo "✅ Private key for $VMNAME moved and symlinked."
else
    echo "⚠️ No private key found for $VMNAME at $KEYFILE"
fi