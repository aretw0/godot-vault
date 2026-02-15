#!/bin/bash
# Script to run tests locally using GUT
# Usage: ./scripts/test.sh

set -e

echo "🧪 Running Godot Unit Tests..."
echo "================================"

# Check if Godot is installed
if ! command -v godot &> /dev/null; then
    echo "❌ Godot not found in PATH"
    echo ""
    echo "Please install Godot 4.3 or add it to your PATH:"
    echo "  - Download from: https://godotengine.org/download"
    echo "  - Or use alias: alias godot='/path/to/Godot'"
    exit 1
fi

echo "Using Godot: $(godot --version)"
echo ""

# Check if test directory exists
if [ ! -d "test" ]; then
    echo "⚠️  No 'test' directory found"
    echo ""
    echo "To add tests:"
    echo "  1. Install GUT addon"
    echo "  2. Create test/ directory"
    echo "  3. Add test files (e.g., test_example.gd)"
    echo ""
    echo "Skipping tests..."
    exit 0
fi

# Check if GUT is installed
if [ ! -d "addons/gut" ]; then
    echo "❌ GUT (Godot Unit Test) addon not found"
    echo ""
    echo "Please install GUT:"
    echo "  1. Download from: https://github.com/bitwes/Gut"
    echo "  2. Extract to addons/gut/"
    echo "  3. Enable plugin in Godot editor"
    exit 1
fi

# Run tests
echo "Running tests..."
godot --headless -s addons/gut/gut_cmdln.gd

exit_code=$?

echo ""
if [ $exit_code -eq 0 ]; then
    echo "✅ All tests passed!"
else
    echo "❌ Some tests failed"
fi

exit $exit_code
