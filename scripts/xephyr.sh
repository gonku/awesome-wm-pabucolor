#!/bin/bash
Xephyr -ac  -noreset -screen 800x600 :1 &
#Xephyr -ac  -noreset -screen 1024x768 :1 &
sleep 5
DISPLAY=:1.0
sleep 5 
awesome -c ~/.config/awesome/test.lua
