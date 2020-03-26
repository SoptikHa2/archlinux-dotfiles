#!/bin/bash
jq '.messages[]' fixed-messages.json | tr -d '{\n' | tr '}' '\n' | grep         ' *"sender_name"' | sed 's/"[^"]*": //g' | sed 's/\[          //'
