#!/bin/bash

# Master Script for Flutter Installation and Fastforge Build
# This script runs the Flutter installation script first, then the Fastforge build script

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Main execution
main() {
    print_status "Starting Master Setup Script"
    print_status "============================="
    
    # Check if installation script exists
    if [ ! -f "./install_flutter_linux.sh" ]; then
        print_error "install_flutter_linux.sh not found in current directory!"
        exit 1
    fi
    
    # Check if Fastforge build script exists
    if [ ! -f "./fastforge_linux_automation.sh" ]; then
        print_error "fastforge_linux_automation.sh not found in current directory!"
        exit 1
    fi
    
    # Run Flutter installation script
    print_status "Running Flutter installation script..."
    bash ./install_flutter_linux.sh
    
    # Add Flutter to PATH for current session
    export PATH="$PATH:$HOME/development/flutter/bin"
    
    # Verify Flutter is available
    if ! command -v flutter >/dev/null 2>&1; then
        print_error "Flutter command not found after installation! Please check the installation script."
        exit 1
    fi
    
    print_success "Flutter installation completed successfully"
    
    # Run Fastforge build script
    print_status "Running Fastforge build script..."
    bash ./fastforge_linux_automation.sh
    
    print_success "============================="
    print_success "All scripts executed successfully!"
    print_status "Flutter has been installed and your app has been packaged, installed, and run."
}

main "$@"
