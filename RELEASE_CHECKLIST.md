# App Store Release Checklist

## ✅ Completed Configuration Changes

### Package Name / Bundle ID
- ✅ Android: com.webex.aynsouq
- ✅ iOS: com.webex.aynsouq

### Version Information
- ✅ Version: 1.0.0
- ✅ Build Number: 1

### Android Configuration
- ✅ Updated applicationId to com.webex.aynsouq
- ✅ Set compileSdk to 34
- ✅ Set targetSdk to 34
- ✅ Set minSdk to 21
- ✅ Added multiDexEnabled
- ✅ Updated MainActivity package
- ✅ Added required permissions (INTERNET, ACCESS_NETWORK_STATE)
- ✅ Configured security settings (usesCleartextTraffic, allowBackup)

### iOS Configuration
- ✅ Updated PRODUCT_BUNDLE_IDENTIFIER to com.webex.aynsouq
- ✅ Added NSAppTransportSecurity settings
- ✅ Configured Info.plist

### Assets
- ✅ App icon configured (assets/logo.png)
- ✅ Splash screen configured (assets/splash_screen.png)

### Documentation
- ✅ Privacy Policy created
- ✅ Store listing information prepared

## 📋 Before Submitting to Google Play Store

### 1. Build Configuration
- [ ] Create a keystore for release signing:
  ```bash
  keytool -genkey -v -keystore aynsouq-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias aynsouq
  ```
- [ ] Create `android/key.properties` file:
  ```
  storePassword=<your-store-password>
  keyPassword=<your-key-password>
  keyAlias=aynsouq
  storeFile=<path-to-keystore>/aynsouq-release-key.jks
  ```
- [ ] Update `android/app/build.gradle.kts` to use release signing config
- [ ] Remove debug signing from release build type

### 2. Build Release APK/AAB
- [ ] Run: `flutter build appbundle --release`
- [ ] Test the release build on physical devices
- [ ] Verify app size is optimized

### 3. Google Play Console Setup
- [ ] Create Google Play Developer account ($25 one-time fee)
- [ ] Create new app in Play Console
- [ ] Fill in app details (name, description, category)
- [ ] Upload screenshots (minimum 2, recommended 4-8)
- [ ] Upload feature graphic (1024 x 500)
- [ ] Set content rating questionnaire
- [ ] Add privacy policy URL
- [ ] Set up pricing & distribution
- [ ] Upload release AAB file

### 4. Store Listing Assets
- [ ] Prepare 4-8 screenshots (1080x1920 or 1920x1080)
- [ ] Create feature graphic (1024 x 500)
- [ ] Prepare promotional video (optional)
- [ ] Write compelling app description
- [ ] Add localized content (if applicable)

### 5. Compliance
- [ ] Complete content rating questionnaire
- [ ] Declare ads (if applicable)
- [ ] Set target audience and content
- [ ] Review and accept Google Play policies
- [ ] Complete Data Safety section

## 📋 Before Submitting to Apple App Store

### 1. Apple Developer Account
- [ ] Enroll in Apple Developer Program ($99/year)
- [ ] Create App ID in Apple Developer Portal
- [ ] Create provisioning profiles

### 2. Xcode Configuration
- [ ] Open project in Xcode: `open ios/Runner.xcworkspace`
- [ ] Select your development team in Signing & Capabilities
- [ ] Configure signing certificates
- [ ] Update bundle identifier to com.webex.aynsouq
- [ ] Set deployment target (iOS 13.0+)

### 3. Build Release IPA
- [ ] Archive the app in Xcode (Product > Archive)
- [ ] Validate the archive
- [ ] Upload to App Store Connect
- [ ] Or use: `flutter build ipa --release`

### 4. App Store Connect Setup
- [ ] Create new app in App Store Connect
- [ ] Fill in app information
- [ ] Upload screenshots for all required device sizes:
  - iPhone 6.7" (1290 x 2796)
  - iPhone 6.5" (1242 x 2688)
  - iPhone 5.5" (1242 x 2208)
  - iPad Pro 12.9" (2048 x 2732)
- [ ] Add app preview video (optional)
- [ ] Set pricing and availability
- [ ] Add privacy policy URL
- [ ] Complete App Privacy details

### 5. Compliance
- [ ] Complete Export Compliance information
- [ ] Set age rating
- [ ] Add App Privacy details
- [ ] Review and accept App Store guidelines
- [ ] Submit for review

## 🔒 Security Checklist

- [ ] Remove all debug/test code
- [ ] Verify no hardcoded API keys or secrets
- [ ] Enable ProGuard/R8 (Android)
- [ ] Test on multiple devices and OS versions
- [ ] Verify SSL/TLS connections
- [ ] Test offline functionality
- [ ] Check for memory leaks

## 🧪 Testing Checklist

- [ ] Test on Android devices (various versions)
- [ ] Test on iOS devices (various versions)
- [ ] Test on tablets
- [ ] Test network connectivity scenarios
- [ ] Test app permissions
- [ ] Verify splash screen and app icon
- [ ] Test deep linking (if applicable)
- [ ] Performance testing
- [ ] Battery usage testing

## 📱 Post-Launch

- [ ] Monitor crash reports
- [ ] Respond to user reviews
- [ ] Track analytics
- [ ] Plan for updates
- [ ] Monitor performance metrics

## 🔗 Useful Commands

### Flutter Commands
```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Build Android APK
flutter build apk --release

# Build Android App Bundle (recommended for Play Store)
flutter build appbundle --release

# Build iOS
flutter build ios --release

# Build IPA
flutter build ipa --release

# Run release mode
flutter run --release
```

### Generate Icons and Splash
```bash
# Generate app icons
flutter pub run flutter_launcher_icons

# Generate splash screens
flutter pub run flutter_native_splash:create
```

## 📞 Support Resources

- [Google Play Console](https://play.google.com/console)
- [Apple App Store Connect](https://appstoreconnect.apple.com)
- [Flutter Deployment Guide](https://docs.flutter.dev/deployment)
- [Android Publishing Guide](https://developer.android.com/studio/publish)
- [iOS Publishing Guide](https://developer.apple.com/app-store/submissions/)
