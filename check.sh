#!/bin/bash
# Run all code quality checks

set -e

echo "🎨 Running black..."
black gpulegion/

echo ""
echo "🔍 Running flake8..."
flake8 gpulegion/

echo ""
echo "🔎 Running pylint..."
pylint gpulegion/

echo ""
echo "🔬 Running mypy..."
mypy gpulegion/

echo ""
echo "✅ All checks passed!"
