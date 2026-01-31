# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1] - 2026-01-31

### Fixed
- **Apple Silicon GPU usage detection**: Fixed regex pattern to correctly parse `GPU HW active residency` from powermetrics output on M1-M5 chips
- Now properly detects GPU usage percentage on Apple M4 Max and other Apple Silicon devices

### Improved
- Enhanced powermetrics output parsing with multiple fallback patterns for better compatibility across macOS versions
- Better error handling for subprocess calls with explicit `check=False` parameter

## [0.1.0] - 2026-01-31

### Added
- **Initial release**: First Python GPU monitoring library with native Apple Silicon support
- **Apple Silicon backend**: Full support for M1-M5 GPU monitoring via powermetrics
  - GPU usage percentage (HW active residency)
  - GPU power consumption in watts
  - Device information (vendor, model, architecture)
- **NVIDIA backend**: Support for NVIDIA GPUs via nvidia-smi
  - GPU utilization percentage
  - GPU power draw
  - GPU memory usage (used/total)
  - Device information (model, driver version, compute capability)
- **Fallback backend**: Graceful degradation when no GPU is detected
- **Cross-platform API**: Unified interface across all backends
  - `backends()` - List available backends
  - `is_available()` - Check GPU availability
  - `usage()` - Get GPU usage percentage
  - `power()` - Get GPU power consumption
  - `memory()` - Get GPU memory info
  - `device()` - Get device information
- **Zero dependencies**: Uses only Python standard library
- **Type hints**: Full mypy type checking support
- **Quality tooling**: 
  - Black formatting
  - Flake8 linting
  - Pylint (10/10 score)
  - Mypy type checking

### Documentation
- Comprehensive README with installation and usage examples
- Example scripts demonstrating library usage
- macOS setup script for passwordless powermetrics access
- MIT License

### Development
- Makefile with common tasks (check, build, clean, publish)
- Quality check script combining all linters
- PyPI-ready package structure with pyproject.toml
- Development requirements with testing and linting tools

---

## Release Notes

### How to use gpulegion (v0.1.1)

#### Basic Usage

```python
import gpulegion as gl

# Check if GPU monitoring is available
if gl.is_available():
    print(f"GPU Usage: {gl.usage()}%")
    print(f"GPU Power: {gl.power()}W")
    print(f"Device: {gl.device()}")
```

#### Apple Silicon Setup

For Apple Silicon Macs, you need passwordless sudo access to powermetrics:

```bash
# Run the setup script
./setup_macos.sh

# Or manually add to /etc/sudoers.d/powermetrics:
your_username ALL=(ALL) NOPASSWD: /usr/bin/powermetrics
```

#### Installation

```bash
pip install gpulegion
```

See README.md for more examples and detailed usage.

[0.1.1]: https://github.com/kactlabs/gpulegion/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/kactlabs/gpulegion/releases/tag/v0.1.0
