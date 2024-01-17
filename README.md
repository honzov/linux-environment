# LINUX-ENVIRONMENT

## Getting Started with Setup

### Step 1: Install Fish Shell
Begin by installing the Fish shell on your system.

### Step 2: Run Installation Script
Use the `install_tools.fish` script to install utilities. Choose a level based on your needs:

- **Level 0:** Base utilities suitable for a remote system.
- **Level 1:** More standalone utilities for your primary workstation.
- **Level 2:** Additional software for a fully-equipped setup.

Command format:
./install_tools.fish {level}

### Step 3: Run nvironment setup script

Command format:
./setup_env.fish {--main}
- with --main flag for setting shorter prompt on you main workstation

### Other option
Build dockerfile with sshd agent running (note change password of somebody user)