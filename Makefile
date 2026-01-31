.PHONY: check format lint test build clean publish

check: format lint

format:
	@echo "🎨 Formatting code..."
	@black gpulegion/

lint:
	@echo "🔍 Running flake8..."
	@flake8 gpulegion/
	@echo "🔎 Running pylint..."
	@pylint gpulegion/
	@echo "🔬 Running mypy..."
	@mypy gpulegion/

test:
	@echo "🧪 Running tests..."
	@pytest tests/ -v

build: check
	@echo "📦 Building package..."
	@python3 -m build

clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -rf dist/ build/ *.egg-info gpulegion.egg-info
	@find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete

publish: build
	@echo "📤 Publishing to PyPI..."
	@python3 -m twine upload dist/*

help:
	@echo "Available commands:"
	@echo "  make check    - Run all quality checks"
	@echo "  make format   - Format code with black"
	@echo "  make lint     - Run linters (flake8, pylint, mypy)"
	@echo "  make test     - Run tests"
	@echo "  make build    - Build package"
	@echo "  make clean    - Clean build artifacts"
	@echo "  make publish  - Publish to PyPI"
