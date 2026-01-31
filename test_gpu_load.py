#!/usr/bin/env python3
"""Test GPU monitoring under load."""

import gpulegion as gl
import time
import numpy as np


def gpu_workload():
    """Simple computation to stress the GPU."""
    # Create large matrices to trigger GPU usage
    size = 2000
    for _ in range(10):
        a = np.random.rand(size, size)
        b = np.random.rand(size, size)
        c = np.dot(a, b)  # Matrix multiplication
        _ = np.linalg.inv(c + np.eye(size) * 0.1)  # Matrix inversion


def main():
    print("=== GPU Load Test ===\n")
    
    if not gl.is_available():
        print("No GPU detected")
        return
    
    print("Baseline (idle):")
    usage = gl.usage()
    power = gl.power()
    if usage is not None:
        print(f"  Usage: {usage:.1f}%")
    if power is not None:
        print(f"  Power: {power:.2f}W")
    
    print("\nStarting GPU workload...")
    print("(This will take ~10 seconds)\n")
    
    # Start workload in background would be better, but keeping it simple
    try:
        import threading
        workload_thread = threading.Thread(target=gpu_workload)
        workload_thread.start()
        
        time.sleep(1)  # Let workload ramp up
        
        print("Under load:")
        for i in range(5):
            usage = gl.usage()
            power = gl.power()
            
            print(f"Sample {i+1}:")
            if usage is not None:
                print(f"  Usage: {usage:.1f}%")
            if power is not None:
                print(f"  Power: {power:.2f}W")
            
            time.sleep(1)
        
        workload_thread.join()
        
    except ImportError:
        print("Note: Install numpy to run GPU workload test")
        print("  pip install numpy")
    
    print("\nDone!")


if __name__ == "__main__":
    main()
