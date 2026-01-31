#!/bin/bash
# Publish script for gpulegion to PyPI

set -e  # Exit on error

echo "🚀 Publishing gpulegion to PyPI"
echo "================================"

# Check if build and twine are installed
if ! python3 -m pip show build &> /dev/null; then
    echo "❌ 'build' not found. Installing..."
    python3 -m pip install --upgrade build
fi

if ! python3 -m pip show twine &> /dev/null; then
    echo "❌ 'twine' not found. Installing..."
    python3 -m pip install --upgrade twine
fi

# Clean previous builds
echo ""
echo "🧹 Cleaning previous builds..."
rm -rf dist/ build/ *.egg-info gpulegion.egg-info

# Build the package
echo ""
echo "📦 Building package..."
python3 -m build

# Check the package
echo ""
echo "✅ Checking package..."
python3 -m twine check dist/*

# Show what will be uploaded
echo ""
echo "📋 Files to upload:"
ls -lh dist/

# Ask for confirmation
echo ""
read -p "🤔 Upload to PyPI? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ""
    echo "📤 Uploading to PyPI..."
    python3 -m twine upload dist/*
    
    echo ""
    echo "✅ Successfully published to PyPI!"
    echo "🔗 View at: https://pypi.org/project/gpulegion/"
    echo ""
    echo "Test installation with:"
    echo "  pip install --upgrade gpulegion"
else
    echo ""
    echo "❌ Upload cancelled"
    echo ""
    echo "To upload to TestPyPI instead:"
    echo "  python3 -m twine upload --repository testpypi dist/*"
fi
