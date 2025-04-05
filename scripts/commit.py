#!/usr/bin/env python3
import os
import subprocess
from datetime import datetime

# get current timestamp
timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# commit message with timestamp
message = f"Automated commit on {timestamp}"

# Git commands
subprocess.run(["git", "add", "."], check=True)
subprocess.run(["git", "commit", "-m", message], check=True)
subprocess.run(["git", "push", "origin", "main"], check=True)

print(f"commited and pushed: {message}")
