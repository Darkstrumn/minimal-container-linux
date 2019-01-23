#!/bin/bash

gui=0
bridge=""

while getopts gb: opt; do
  case $opt in
  g)
    gui=1
    ;;
  b)
    bridge=$OPTARG
  esac
done

shift $((OPTIND - 1))

echo "Booting..."
echo

if [ -n "$bridge" ]; then
  network=-net bridge,br=br0 -net nic
else
  network=""
fi

if (( gui == 1 )); then
  qemu-system-x86_64 -m 384M -boot d -cdrom mcl.iso -device virtio-rng-pci $network
else
  qemu-system-x86_64 -m 384M -boot d -nographic -cdrom mcl.iso -device virtio-rng-pci $network
fi
