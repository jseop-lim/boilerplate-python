#!/bin/bash

# Interactive project setup script
echo "==== Project Setup ===="
echo ""

# Get project name
read -p "Project name: " project_name
if [ -z "$project_name" ]; then
  echo "Error: Project name cannot be empty"
  exit 1
fi

# Get author name
read -p "Author name : " author_name
if [ -z "$author_name" ]; then
  echo "Error: Author name cannot be empty"
  exit 1
fi

# Get author email
read -p "Author email: " author_email
if [ -z "$author_email" ]; then
  echo "Error: Author email cannot be empty"
  exit 1
fi

echo ""
echo "---- Configuration ----"
echo "Project name: $project_name"
echo "Author name:  $author_name"
echo "Author email: $author_email"
echo ""

# Confirm before proceeding
read -p "Proceed with setup? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Setup cancelled"
  exit 0
fi

echo ""
old="myproject"
new="${project_name//-/_}"

# 1. Rename directory: src/<old> -> src/<new>
echo "=> Renaming directory..."
if [ -d "src/$old" ]; then
  mv "src/$old" "src/$new"
  echo "   ✓ Renamed directory: src/$old -> src/$new"
else
  echo "   ! Warning: Directory src/$old not found"
fi

# 2. Replace string in file contents
echo "=> Updating file contents..."
files_to_update=("pyproject.toml" ".devcontainer/devcontainer.json")

for file in "${files_to_update[@]}"; do
  if [ -f "$file" ]; then
    sed -i '' "s/$old/$new/g" "$file"
    echo "   ✓ Updated file: $file"
  else
    echo "   ! Warning: File $file not found"
  fi
done

# 2.1. Update author information in pyproject.toml
echo "=> Updating author information..."
if [ -f "pyproject.toml" ]; then
  # Update author name
  sed -i '' "s/{ name = \"[^\"]*\"/{ name = \"$author_name\"/g" pyproject.toml
  # Update author email
  sed -i '' "s/email = \"[^\"]*\" }/email = \"$author_email\" }/g" pyproject.toml
  echo "   ✓ Updated author information in pyproject.toml"
else
  echo "   ! Warning: pyproject.toml not found"
fi

# 3. Generate new lock file with updated configuration
echo "=> Generating new lock file..."
uv lock
echo "   ✓ Lock file regenerated"

echo ""
echo "Setup complete! Project '$project_name' is ready."
