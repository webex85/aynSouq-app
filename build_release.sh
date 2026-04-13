#!/bin/bash

# AynSouq Release Build Script
# This script helps build release versions for both Android and iOS

set -e

echo "🚀 AynSouq Release Build Script"
echo "================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

print_success "Flutter found: $(flutter --version | head -n 1)"

# Clean previous builds
echo ""
echo "🧹 Cleaning previous builds..."
flutter clean
print_success "Clean completed"

# Get dependencies
echo ""
echo "📦 Getting dependencies..."
flutter pub get
print_success "Dependencies fetched"

# Generate icons and splash screens
echo ""
echo "🎨 Generating app icons and splash screens..."
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
print_success "Icons and splash screens generated"

# Build selection
echo ""
echo "Select build type:"
echo "1) Android APK"
echo "2) Android App Bundle (AAB) - Recommended for Play Store"
echo "3) iOS IPA"
echo "4) Both Android and iOS"
echo "5) Exit"
echo ""
read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo ""
        echo "🤖 Building Android APK..."
        flutter build apk --release
        print_success "Android APK built successfully!"
        echo "Location: build/app/outputs/flutter-apk/app-release.apk"
        ;;
    2)
        echo ""
        echo "🤖 Building Android App Bundle..."
        
        # Check if key.properties exists
        if [ ! -f "android/key.properties" ]; then
            print_warning "android/key.properties not found!"
            echo "The app will be signed with debug keys."
            echo "For production release, create key.properties from key.properties.template"
            read -p "Continue anyway? (y/n): " continue
            if [ "$continue" != "y" ]; then
                exit 1
            fi
        fi
        
        flutter build appbundle --release
        print_success "Android App Bundle built successfully!"
        echo "Location: build/app/outputs/bundle/release/app-release.aab"
        ;;
    3)
        echo ""
        echo "🍎 Building iOS IPA..."
        
        # Check if on macOS
        if [[ "$OSTYPE" != "darwin"* ]]; then
            print_error "iOS builds require macOS"
            exit 1
        fi
        
        flutter build ipa --release
        print_success "iOS IPA built successfully!"
        echo "Location: build/ios/ipa/aynsouq.ipa"
        ;;
    4)
        echo ""
        echo "🤖 Building Android App Bundle..."
        flutter build appbundle --release
        print_success "Android App Bundle built successfully!"
        
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo ""
            echo "🍎 Building iOS IPA..."
            flutter build ipa --release
            print_success "iOS IPA built successfully!"
        else
            print_warning "Skipping iOS build (requires macOS)"
        fi
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        print_error "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "================================"
print_success "Build process completed!"
echo ""
echo "📋 Next steps:"
echo "1. Test the release build on physical devices"
echo "2. Review DEPLOYMENT_GUIDE.md for upload instructions"
echo "3. Upload to respective app stores"
echo ""
