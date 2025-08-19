#!/bin/bash
while IFS= read -r line; do
  # Skip empty or comment lines
  if [[ "$line" =~ ^[[:space:]]*$ ]] || [[ "$line" =~ ^# ]]; then
    continue
  fi

  # Split key and value
  IFS="=" read -r key value <<< "$line"

  # Remove surrounding whitespace
  key=$(echo "$key" | xargs)
  value=$(echo "$value" | xargs)

  # Use eval to expand variables in the value before exporting
  eval export "$key=$value"
done < "$1"
