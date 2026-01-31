#!/usr/bin/env python3
"""Example usage of gpulegion."""

import gpulegion as gl
import time


def main():
    print("=== gpulegion Example ===\n")
    
    # Check available backends
    print(f"Available backends: {gl.backends()}")
    print(f"GPU available: {gl.is_available()}\n")
    
    if not gl.is_available():
        print("No GPU detected on this system.")
        return
    
    # Get device info
    device = gl.device()
    if device:
        print("Device Information:")
        for key, value in device.items():
            print(f"  {key}: {value}")
        print()
    
    # Monitor GPU for a few seconds
    print("Monitoring GPU (5 samples)...")
    for i in range(5):
        usage = gl.usage()
        power_draw = gl.power()
        mem = gl.memory()
        
        print(f"Sample {i+1}:")
        if usage is not None:
            print(f"  Usage: {usage:.1f}%")
        if power_draw is not None:
            print(f"  Power: {power_draw:.2f}W")
        if mem is not None:
            print(f"  Memory: {mem['used_mb']:.0f}MB / {mem['total_mb']:.0f}MB")
        
        if i < 4:
            time.sleep(1)
    
    print("\nDone!")


if __name__ == "__main__":
    main()
