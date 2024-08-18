#!/bin/sh

bl_device=/sys/class/backlight/amdgpu_bl1/brightness
echo $(($(cat $bl_device)+1)) | sudo tee $bl_device
