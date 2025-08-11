#!/bin/bash

# Number of files per commit (random 2 or 3)
min_files=2
max_files=3

# Get the list of untracked files
files=$(git ls-files --others --exclude-standard)

if [ -z "$files" ]; then
    echo "No new files to add."
    exit 0
fi

# Convert to array
files_array=($files)

# Commit counter
commit_num=1

while [ ${#files_array[@]} -gt 0 ]; do
    # Pick random batch size: 2 or 3
    batch_size=$(( RANDOM % (max_files - min_files + 1) + min_files ))

    # Slice the first N files
    batch=("${files_array[@]:0:$batch_size}")

    # Remove them from the array
    files_array=("${files_array[@]:$batch_size}")

    echo "Adding and committing batch $commit_num with ${#batch[@]} file(s)..."
    
    # Stage files
    git add "${batch[@]}"
    
    # Commit
    git commit -m "Auto commit #$commit_num"

    # Push
    git push

    ((commit_num++))
done

echo "All files committed and pushed!"
