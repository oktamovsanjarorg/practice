#!/bin/bash

# VAZIFA: credentials.txt faylidagi parollarni shunday yuklangki,
# pastdagi python3 dasturi ularni ko'ra olsin!
# (credentials.txt yoki app.py fayllariga tegilmasin)
set -a
source credentials.txt
set +a
python3 app.py
