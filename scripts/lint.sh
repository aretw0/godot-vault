#!/bin/bash
# Script to run GDScript linter locally
# Usage: ./scripts/lint.sh

set -e

echo "🔍 Installing/Updating gdtoolkit..."
pip install --quiet --upgrade gdtoolkit==4.3.1

echo ""
echo "🔍 Linting GDScript files..."
echo "================================"

# Find and lint all .gd files
found_errors=0
file_count=0

while IFS= read -r file; do
    file_count=$((file_count + 1))
    echo "Checking: $file"
    if ! gdlint "$file"; then
        found_errors=$((found_errors + 1))
    fi
done < <(find . -name "*.gd" -type f -not -path "./.godot/*" -not -path "./addons/*")

echo ""
echo "================================"
echo "📊 Summary:"
echo "   Files checked: $file_count"

if [ $found_errors -eq 0 ]; then
    echo "   ✅ No linting errors found!"
    exit 0
else
    echo "   ❌ Found errors in $found_errors file(s)"
    echo ""
    echo "💡 Tip: You can auto-format files with: gdformat ."
    exit 1
fi
