import os
import time
import sys

def wait_for_log(log_path, search_term="final_", timeout=3600):
    """
    Waits until the log file exists and contains a specific term.
    log_path: Path to the Slurm .out log file
    search_term: A term that indicates the job has finished (e.g., 'Final BPB')
    timeout: Safety timeout after 1 hour (in seconds)
    """
    start_time = time.time()
    print(f"⏳ Begin monitoring {log_path}...")

    while True:
        # 1. Check if the file exists at all
        if os.path.exists(log_path):
            with open(log_path, "r") as f:
                content = f.read()
                if search_term in content:
                    print(f"✅ Target achieved: '{search_term}' found in log!")
                    return True
                elif "Traceback" in content:
                    print("❌ Job failed: 'Traceback' found in log.")
                    sys.exit(1)
        
        # 2. Timeout check (in case the job crashes and never finishes)
        if time.time() - start_time > timeout:
            print("❌ Timeout: Job took too long or log path is incorrect.")
            sys.exit(1)

        # 3. Sleep briefly to avoid busy-waiting
        time.sleep(30) 

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python wait_for_job.py <path_to_log>")
        sys.exit(1)
    
    wait_for_log(sys.argv[1])