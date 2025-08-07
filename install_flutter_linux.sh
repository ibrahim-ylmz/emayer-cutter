#!/bin/bash

# Flutter Linux Installation Script
# This script automatically installs Flutter SDK on Linux systems

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

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check system architecture
get_architecture() {
    ARCH=$(uname -m)
    case $ARCH in
        x86_64)
            echo "x64"
            ;;
        armv7l)
            echo "arm32"
            ;;
        aarch64)
            echo "arm64"
            ;;
        *)
            echo "Unsupported architecture: $ARCH"
            exit 1
            ;;
    esac
}

# Install dependencies
install_dependencies() {
    print_status "Installing system dependencies..."
    
    # Check if we're on Ubuntu/Debian or Fedora/CentOS
    if command_exists apt; then
        sudo apt update
        sudo apt install -y git curl unzip clang cmake ninja-build pkg-config libgtk-3-dev
    elif command_exists yum; then
        sudo yum install -y git curl unzip clang cmake ninja-build pkg-config gtk3-devel
    elif command_exists dnf; then
        sudo dnf install -y git curl unzip clang cmake ninja-build pkg-config gtk3-devel
    else
        print_warning "Unknown package manager. Please install git, curl, and unzip manually."
        if ! command_exists git || ! command_exists curl || ! command_exists unzip; then
            print_error "Required system tools (git, curl, unzip) are missing!"
            exit 1
        fi
    fi
    
    print_success "System dependencies installed successfully"
}

# Download and install Flutter
install_flutter() {
    print_status "Downloading and installing Flutter SDK..."
    
    # Get system architecture
    ARCH=$(get_architecture)
    FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.32.8-stable.tar.xz"
    
    # Create temporary directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    # Download Flutter SDK
    print_status "Downloading Flutter from: $FLUTTER_URL"
    curl -O "$FLUTTER_URL"
    
    # Extract Flutter SDK
    print_status "Extracting Flutter SDK..."
    tar xf flutter_linux_3.32.8-stable.tar.xz
    
    # Create development directory if it doesn't exist
    mkdir -p "$HOME/development"
    
    # Move to development directory
    print_status "Installing Flutter to $HOME/development/flutter..."
    mv flutter "$HOME/development/flutter"
    
    cd "$HOME"
    rm -rf "$TEMP_DIR"
    
    print_success "Flutter SDK installed successfully"
}

# Add Flutter to PATH
add_to_path() {
    print_status "Adding Flutter to PATH..."
    
    # Add to .bashrc if not already present
    if ! grep -q "export PATH=\$PATH:\$HOME/development/flutter/bin" ~/.bashrc; then
        echo "export PATH=\$PATH:\$HOME/development/flutter/bin" >> ~/.bashrc
        print_success "Added Flutter to PATH in ~/.bashrc"
    else
        print_warning "Flutter already in PATH, skipping"
    fi
    
    # Add to .profile if not already present
    if ! grep -q "export PATH=\$PATH:\$HOME/development/flutter/bin" ~/.profile; then
        echo "export PATH=\$PATH:\$HOME/development/flutter/bin" >> ~/.profile
        print_success "Added Flutter to PATH in ~/.profile"
    else
        print_warning "Flutter already in PATH, skipping"
    fi
    
    # Add to .zshrc if using zsh and file exists
    if command_exists zsh && [ -f ~/.zshrc ]; then
        if ! grep -q "export PATH=\$PATH:\$HOME/development/flutter/bin" ~/.zshrc; then
            echo "export PATH=\$PATH:\$HOME/development/flutter/bin" >> ~/.zshrc
            print_success "Added Flutter to PATH in ~/.zshrc"
        else
            print_warning "Flutter already in PATH, skipping"
        fi
    fi
    
    # Refresh terminal session by sourcing bashrc
    source ~/.bashrc
}

# Verify installation
verify_installation() {
    print_status "Verifying Flutter installation..."
    
    # Source the bashrc to update PATH in current session
    source ~/.bashrc
    
    # Check Flutter version
    if command_exists flutter; then
        FLUTTER_VERSION=$(flutter --version | head -n 1)
        print_success "Flutter installed: $FLUTTER_VERSION"
    else
        print_error "Flutter installation failed or PATH not updated correctly!"
        exit 1
    fi
    
    # Run Flutter doctor
    print_status "Running flutter doctor..."
    flutter doctor
    
    print_success "Flutter installation verified successfully"
}

# Main execution
main() {
    print_status "Starting Flutter Linux Installation Script"
    print_status "=========================================="
    
    # Check prerequisites
    if ! command_exists curl; then
        print_error "curl is required but not installed!"
        exit 1
    fi
    
    if ! command_exists tar; then
        print_error "tar is required but not installed!"
        exit 1
    fi
    
    # Install dependencies
    install_dependencies
    
    # Install Flutter
    install_flutter
    
    # Add to PATH
    add_to_path
    
    # Verify installation
    verify_installation
    
    print_success "=========================================="
    print_success "Flutter Linux installation completed successfully!"
    print_status "Please restart your terminal or run 'source ~/.bashrc' to use Flutter commands."
    print_status "Then you can run 'flutter doctor' to check your setup."
}

main "$@"
