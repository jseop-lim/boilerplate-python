#!/usr/bin/env bash

set -euo pipefail

# Remove dependabot configuration file
if [ -f ".github/dependabot.yml" ]; then
    rm ".github/dependabot.yml"
    echo "Removed .github/dependabot.yml"
fi

# Remove update-pre-commit workflow file
if [ -f ".github/workflows/update-pre-commit.yml" ]; then
    rm ".github/workflows/update-pre-commit.yml"
    echo "Removed .github/workflows/update-pre-commit.yml"
fi

echo "Cleanup complete."
