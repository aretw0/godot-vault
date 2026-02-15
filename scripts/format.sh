#!/bin/bash
# Script to auto-format GDScript files locally
# Usage: ./scripts/format.sh

set -e

echo "🔧 Installing/Updating gdtoolkit..."
pip install --quiet --upgrade gdtoolkit==4.3.1

echo ""
echo "🔧 Formatting GDScript files..."
echo "================================"

# Format all .gd files
gdformat .

echo ""
echo "✅ Formatting complete!"
echo ""
echo "💡 Run './scripts/lint.sh' to verify the changes"
