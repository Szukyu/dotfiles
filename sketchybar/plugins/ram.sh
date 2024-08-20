#!/bin/bash

RAM=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5"%") }')

sketchybar --set $NAME \
  icon= \
  icon.color=0xfffab387 \
  label="$RAM%"
