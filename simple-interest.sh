#!/bin/bash
# Simple Interest Calculator

echo "Enter Principal:"
read p
echo "Enter Rate of Interest:"
read r
echo "Enter Time (years):"
read t

si=$(echo "scale=2; ($p * $r * $t) / 100" | bc)
echo "Simple Interest is: $si"
