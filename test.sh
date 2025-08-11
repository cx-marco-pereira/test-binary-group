#!/bin/bash

# List of possible extensions
extensions=(
    ".cxsca-results.json"
    ".cxsca-sast-results.json"
    ".cxsca-topology-results.json"
    ".cxsca.sig"
    ".jar"
    ".war"
    ".ear"
    ".zip"
    ".gz"
)

# Target total size in GB
total_gb=6
# Size per file in MB
file_size_mb=100

# Calculate number of files
num_files=$(( total_gb * 1024 / file_size_mb ))

echo "Creating $num_files files of $file_size_mb MB each (~${total_gb}GB total)..."

for i in $(seq 1 $num_files); do
    # Pick a random extension
    ext=${extensions[$RANDOM % ${#extensions[@]}]}

    # File name
    filename="file-$i$ext"

    # Create incompressible random data using /dev/urandom
    dd if=/dev/urandom of="$filename" bs=1M count=$file_size_mb status=progress

done

echo "Done! Created $num_files files."
