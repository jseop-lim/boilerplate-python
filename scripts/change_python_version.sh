#!/bin/bash

# Script to change Python version and reset uv virtual environment

echo "==== Change Python Version ===="
echo ""

# Get current Python version
current_version=$(cat .python-version 2>/dev/null || echo "not set")
echo "Current Python version: $current_version"
echo ""

# Get new Python version
read -p "New Python version (e.g., 3.12.10, 3.13.1): " new_version
if [ -z "$new_version" ]; then
  echo "Error: Python version cannot be empty"
  exit 1
fi

# Validate version format (basic check)
if [[ ! "$new_version" =~ ^3\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: Invalid version format. Expected format: 3.x.y (e.g., 3.12.10)"
  exit 1
fi

echo ""
echo "---- Configuration ----"
echo "Current version: $current_version"
echo "New version:     $new_version"
echo ""

# Confirm before proceeding
read -p "Proceed with version change? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Version change cancelled"
  exit 0
fi

echo ""

# 1. Update .python-version file
echo "=> Updating .python-version..."
echo "$new_version" > .python-version
echo "   ✓ Updated .python-version to $new_version"

# 2. Update pyproject.toml and CI workflow Python version settings
echo "=> Updating pyproject.toml..."
major_minor=$(echo "$new_version" | cut -d'.' -f1-2)
py_version=$(echo "$major_minor" | tr -d '.')

# Update requires-python
sed -i '' "s/requires-python = \">=.*\"/requires-python = \">=$major_minor\"/" pyproject.toml
# Update tool.mypy.python_version
sed -i '' "s/python_version = \".*\"/python_version = \"$major_minor\"/" pyproject.toml
# Update tool.ruff.target-version
sed -i '' "s/target-version = \"py[0-9]*\"/target-version = \"py$py_version\"/" pyproject.toml

echo "   ✓ Updated Python version settings in pyproject.toml"

echo "=> Updating CI workflow..."
# Update matrix.python-version in ci.yml
sed -i '' "s/- \"[0-9]*\.[0-9]*\"/- \"$major_minor\"/" .github/workflows/ci.yml

echo "   ✓ Updated Python version in CI workflow"

# 3. Remove existing virtual environment
echo "=> Removing existing virtual environment..."
if [ -d ".venv" ]; then
  rm -rf .venv
  echo "   ✓ Removed .venv directory"
else
  echo "   ! Warning: .venv directory not found"
fi

# 4. Check if Python version exists in shell, otherwise install with uv
echo "=> Checking Python $new_version..."
should_install=true
if uv python list | grep -q "$new_version"; then
  echo "   ✓ Python $new_version available to uv"
  should_install=false
fi
if [ "$should_install" = true ]; then
  echo "   Installing Python $new_version with uv..."
  if uv python install "$new_version"; then
    echo "   ✓ Python $new_version installed"
  else
    echo "   ✗ Failed to install Python $new_version"
    exit 1
  fi
fi

# 5. Create new virtual environment and sync dependencies
echo "=> Creating new virtual environment and syncing dependencies..."
if uv sync; then
  echo "   ✓ Virtual environment created and dependencies synchronized"
else
  echo "   ✗ Failed to sync dependencies"
  exit 1
fi

echo ""
echo "Python version changed successfully to $new_version!"
echo "Virtual environment has been recreated."
