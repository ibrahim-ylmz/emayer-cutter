#!/bin/bash

# Fastforge Linux Automation Script
# This script automates the entire Fastforge workflow for Linux:
# 1. Activates Fastforge globally
# 2. Creates necessary configuration files
# 3. Packages the Flutter app as .deb
# 4. Installs the generated .deb package
# 5. Runs the installed application

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

# Check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    if ! command_exists dart; then
        print_error "Dart SDK is not installed or not in PATH"
        exit 1
    fi
    
    if ! command_exists flutter; then
        print_error "Flutter SDK is not installed or not in PATH"
        exit 1
    fi
    
    print_success "Prerequisites check passed"
}

# Activate Fastforge globally
activate_fastforge() {
    print_status "Activating Fastforge globally..."
    
    # Check if already activated
    if dart pub global list | grep -q "fastforge"; then
        print_warning "Fastforge is already activated, updating to latest version..."
        dart pub global deactivate fastforge
    fi
    
    dart pub global activate fastforge
    print_success "Fastforge activated successfully"
    
    # Add PATH export to ~/.bashrc if not already present
    PUB_CACHE_PATH="$HOME/.pub-cache/bin"
    if ! grep -q "export PATH=.*$PUB_CACHE_PATH" ~/.bashrc; then
        echo "export PATH="\$PATH:\$HOME/.pub-cache/bin"" >> ~/.bashrc
        print_success "Added Dart pub cache to PATH in ~/.bashrc"
    else
        print_warning "Dart pub cache already in PATH, skipping"
    fi
}

# Check and validate existing configuration files
check_config_files() {
    print_status "Checking required configuration files..."
    
    local missing_files=false
    
    # Check distribute_options.yaml
    if [ -f "distribute_options.yaml" ]; then
        print_success "distribute_options.yaml found - using existing configuration"
    else
        print_error "distribute_options.yaml not found! Please create this file first."
        missing_files=true
    fi
    
    # Check make_config.yaml for DEB packaging
    if [ -f "linux/packaging/deb/make_config.yaml" ]; then
        print_success "make_config.yaml found - using existing DEB configuration"
    else
        print_error "linux/packaging/deb/make_config.yaml not found! Please create this file first."
        missing_files=true
    fi
    
    if [ "$missing_files" = true ]; then
        print_error "Required configuration files are missing. Please create them before running this script."
        exit 1
    fi
}



# Package the application
package_app() {
    print_status "Packaging Flutter application for Linux..."
    
    # Clean previous builds
    if [ -d "dist" ]; then
        print_status "Cleaning previous builds..."
        rm -rf dist/
    fi
    
    # Run fastforge package command
    print_status "Running fastforge package command..."
    fastforge package --platform linux --targets deb
    
    print_success "Application packaged successfully"
}

# Find and install the generated .deb package
install_package() {
    print_status "Installing the generated .deb package..."
    
    # Find the .deb file in dist directory
    DEB_FILE=$(find dist/ -name "*.deb" -type f | head -n 1)
    
    if [ -z "$DEB_FILE" ]; then
        print_error "No .deb file found in dist/ directory"
        exit 1
    fi
    
    print_status "Found .deb package: $DEB_FILE"
    
    # Install the package
    print_status "Installing package (requires sudo)..."
    sudo dpkg -i "$DEB_FILE"
    
    # Fix dependencies if needed
    print_status "Fixing dependencies if needed..."
    sudo apt-get install -f -y
    
    print_success "Package installed successfully"
}

# Run the installed application
run_application() {
    print_status "Attempting to run the installed application..."
    
    # Get app name from pubspec.yaml
    APP_NAME=$(grep "^name:" pubspec.yaml | cut -d' ' -f2 | tr -d '\r')
    
    if [ -z "$APP_NAME" ]; then
        print_error "Could not determine application name from pubspec.yaml"
        exit 1
    fi
    
    # Try to run the application
    print_status "Starting application: $APP_NAME"
    
    # Check if the application binary exists in common locations
    if command_exists "$APP_NAME"; then
        print_success "Running application: $APP_NAME"
        nohup "$APP_NAME" > /dev/null 2>&1 &
        print_success "Application started in background (PID: $!)"
    elif [ -f "/usr/bin/$APP_NAME" ]; then
        print_success "Running application from /usr/bin/$APP_NAME"
        nohup "/usr/bin/$APP_NAME" > /dev/null 2>&1 &
        print_success "Application started in background (PID: $!)"
    elif [ -f "/opt/$APP_NAME/$APP_NAME" ]; then
        print_success "Running application from /opt/$APP_NAME/$APP_NAME"
        nohup "/opt/$APP_NAME/$APP_NAME" > /dev/null 2>&1 &
        print_success "Application started in background (PID: $!)"
    else
        print_warning "Could not find application binary. You may need to run it manually."
        print_status "Try running: $APP_NAME"
        print_status "Or check installed applications in your application menu"
    fi
}

# Cleanup function
cleanup() {
    print_status "Cleaning up temporary files..."
    # Add any cleanup operations here if needed
}

# Main execution
main() {
    print_status "Starting Fastforge Linux Automation Script"
    print_status "=========================================="
    
    # Check if we're in a Flutter project directory
    if [ ! -f "pubspec.yaml" ]; then
        print_error "This script must be run from a Flutter project directory (pubspec.yaml not found)"
        exit 1
    fi
    
    # Execute all steps
    check_prerequisites
    activate_fastforge
    check_config_files
    package_app
    install_package
    run_application
    
    print_success "=========================================="
    print_success "Fastforge Linux automation completed successfully!"
    print_status "Your Flutter application has been:"
    print_status "  ✓ Packaged as a .deb file"
    print_status "  ✓ Installed on your system"
    print_status "  ✓ Started (if possible)"
    print_status ""
    print_status "You can also find your application in the system menu or run it manually."
}

# Handle script interruption
trap cleanup EXIT

# Run main function
main "$@"
