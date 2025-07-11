#!/bin/bash

old="$1"
new="$2"

if [ -z "$old" ] || [ -z "$new" ]; then
  echo "Usage: $0 <old_name> <new_name>"
  exit 1
fi

# 1. Rename directory: src/<old> -> src/<new>
echo "=> Renaming directory..."
if [ -d "src/$old" ]; then
  mv "src/$old" "src/$new"
  echo "   ✓ Renamed directory: src/$old -> src/$new"
else
  echo "   ⚠ Warning: Directory src/$old not found"
fi

# 2. Replace string in file contents
echo "=> Updating file contents..."
files_to_update=("pyproject.toml" ".devcontainer/devcontainer.json")

for file in "${files_to_update[@]}"; do
  if [ -f "$file" ]; then
    sed -i '' "s/$old/$new/g" "$file"
    echo "   ✓ Updated file: $file"
  else
    echo "   ⚠ Warning: File $file not found"
  fi
done

# 3. Generate new lock file with updated configuration
echo "=> Generating new lock file..."
uv lock
echo "   ✓ Lock file regenerated"
