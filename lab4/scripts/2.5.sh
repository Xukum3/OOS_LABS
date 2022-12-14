#!/bin/bash
find ~ -type f -name "*.txt" > /tmp/2_5.txt
cat /tmp/2_5.txt
du -h /tmp/2_5.txt | cut -f1
cat /tmp/2_5.txt | xargs wc -l | tail -1
rm /tmp/2_5.txt
