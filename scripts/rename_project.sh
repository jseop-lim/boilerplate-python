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
if [ -z "$author_email" ] || [[ ! "$author_email" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
  echo "Error: Invalid email format"
  exit 1
fi

echo ""
echo "---- Configuration ----"
echo "Project name: $project_name"
echo "Author name : $author_name"
echo "Author email: $author_email"
echo ""

# Confirm before proceeding
read -p "Proceed with setup? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Setup cancelled"
  exit 0
fi

echo ""
old_project_name=$(uv version | cut -d' ' -f1)
old_module_name="${old_project_name//-/_}"
new_project_name="$project_name"
new_module_name="${project_name//-/_}"

# 1. Rename directory: src/<old_module_name> -> src/<new_module_name>
echo "=> Renaming directory..."
if [ -d "src/$old_module_name" ]; then
  mv "src/$old_module_name" "src/$new_module_name"
  echo "   ✓ Renamed directory: src/$old_module_name -> src/$new_module_name"
else
  echo "   ! Warning: Directory src/$old_module_name not found"
fi

# 2. Replace project name in file contents
echo "=> Updating project name..."
files_to_update=("pyproject.toml" ".devcontainer/devcontainer.json")

for file in "${files_to_update[@]}"; do
  if [ -f "$file" ]; then
    sed -i '' "s/$old_project_name/$new_project_name/g" "$file"
    echo "   ✓ Updated project name in: $file"
  else
    echo "   ! Warning: File $file not found"
  fi
done

# 3. Replace module name in file contents
echo "=> Updating module name..."
files_to_update=("pyproject.toml")

for file in "${files_to_update[@]}"; do
  if [ -f "$file" ]; then
    sed -i '' "s/$old_module_name/$new_module_name/g" "$file"
    echo "   ✓ Updated module name in: $file"
  else
    echo "   ! Warning: File $file not found"
  fi
done

# 4. Update author information in pyproject.toml
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

# 5. Generate new lock file with updated configuration
echo "=> Generating new lock file..."
if uv lock; then
  echo "   ✓ Lock file regenerated"
else
  echo "   ✗ Failed to regenerate lock file"
  exit 1
fi

# 6. Sync dependencies with updated configuration
echo "=> Syncing dependencies..."
if uv sync; then
  echo "   ✓ Dependencies synchronized"
else
  echo "   ✗ Failed to sync dependencies"
  exit 1
fi

echo ""
echo "Setup complete! Project '$project_name' is ready."
