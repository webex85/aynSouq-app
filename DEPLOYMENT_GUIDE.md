# AynSouq - Deployment Guide

This guide will walk you through deploying AynSouq to Google Play Store and Apple App Store.

## Prerequisites

- Flutter SDK installed and configured
- Android Studio (for Android builds)
- Xcode (for iOS builds, macOS only)
- Google Play Developer account ($25 one-time)
- Apple Developer account ($99/year)

## Current Configuration

- **Package Name (Android):** com.webex.aynsouq
- **Bundle ID (iOS):** com.webex.aynsouq
- **Version:** 1.0.0
- **Build Number:** 1

## 🤖 Android Deployment (Google Play Store)

### Step 1: Create Release Keystore

Generate a keystore for signing your app:

```bash
keytool -genkey -v -keystore aynsouq-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias aynsouq
```

**Important:** Store this keystore file securely! You'll need it for all future updates.

### Step 2: Configure Signing

1. Copy `android/key.properties.template` to `android/key.properties`
2. Edit `android/key.properties` with your keystore details:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=aynsouq
storeFile=../aynsouq-release-key.jks
```

### Step 3: Build Release Bundle

```bash
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release

# Or build APK
flutter build apk --release
```

The output will be at:
- AAB: `build/app/outputs/bundle/release/app-release.aab`
- APK: `build/app/outputs/flutter-apk/app-release.apk`

### Step 4: Google Play Console Setup

1. Go to [Google Play Console](https://play.google.com/console)
2. Create a new app
3. Fill in app details:
   - **App name:** AynSouq
   - **Default language:** English (United States)
   - **App or game:** App
   - **Free or paid:** Free

4. **Store listing:**
   - Use descriptions from `STORE_LISTING.md`
   - Upload screenshots (minimum 2)
   - Upload feature graphic (1024 x 500)

5. **Content rating:**
   - Complete the questionnaire
   - Should be rated for Everyone

6. **App content:**
   - Privacy policy: Upload `PRIVACY_POLICY.md` to your website and provide URL
   - Ads: Declare if your app contains ads
   - Target audience: Set appropriate age groups

7. **Data safety:**
   - Complete the data safety form
   - Declare what data you collect

8. **Release:**
   - Create a new release
   - Upload the AAB file
   - Add release notes
   - Submit for review

## 🍎 iOS Deployment (Apple App Store)

### Step 1: Apple Developer Setup

1. Enroll in [Apple Developer Program](https://developer.apple.com/programs/)
2. Create App ID:
   - Go to Certificates, Identifiers & Profiles
   - Create new identifier
   - Bundle ID: `com.webex.aynsouq`

### Step 2: Xcode Configuration

```bash
# Open iOS project in Xcode
open ios/Runner.xcworkspace
```

In Xcode:
1. Select Runner in the project navigator
2. Go to Signing & Capabilities
3. Select your Team
4. Ensure Bundle Identifier is `com.webex.aynsouq`
5. Enable "Automatically manage signing"

### Step 3: Build Release

Option A - Using Xcode:
1. Select "Any iOS Device" as the build target
2. Product > Archive
3. Once archived, click "Distribute App"
4. Select "App Store Connect"
5. Follow the wizard to upload

Option B - Using Flutter:
```bash
flutter build ipa --release
```

The IPA will be at: `build/ios/ipa/aynsouq.ipa`

### Step 4: App Store Connect Setup

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Create a new app:
   - **Platform:** iOS
   - **Name:** AynSouq
   - **Primary Language:** English (U.S.)
   - **Bundle ID:** com.webex.aynsouq
   - **SKU:** aynsouq-001

3. **App Information:**
   - Use descriptions from `STORE_LISTING.md`
   - Category: Shopping
   - Content Rights: Check if applicable

4. **Pricing and Availability:**
   - Price: Free
   - Availability: All territories

5. **App Privacy:**
   - Privacy Policy URL: Upload `PRIVACY_POLICY.md` to your website
   - Complete privacy questions

6. **Prepare for Submission:**
   - Upload screenshots for all required sizes:
     - iPhone 6.7" (1290 x 2796)
     - iPhone 6.5" (1242 x 2688)
     - iPad Pro 12.9" (2048 x 2732)
   - Add app preview video (optional)
   - Fill in promotional text
   - Add keywords
   - Support URL
   - Marketing URL (optional)

7. **Build:**
   - Select the uploaded build
   - Add "What's New" text

8. **Submit for Review:**
   - Complete all required fields
   - Submit for review

## 📸 Required Assets

### Screenshots

You need to create screenshots showing your app in action:

**Android:**
- Minimum 2, recommended 4-8
- Size: 1080 x 1920 (portrait) or 1920 x 1080 (landscape)

**iOS:**
- iPhone 6.7": 1290 x 2796
- iPhone 6.5": 1242 x 2688
- iPhone 5.5": 1242 x 2208
- iPad Pro 12.9": 2048 x 2732

### Feature Graphic (Android only)
- Size: 1024 x 500 pixels
- Format: PNG or JPEG

### App Icon
Already configured in `assets/logo.png`
- Should be 1024 x 1024 pixels
- No transparency
- No rounded corners (handled by OS)

## 🧪 Testing Before Release

```bash
# Test release build on Android
flutter build apk --release
flutter install

# Test release build on iOS
flutter build ios --release
# Then run from Xcode
```

Test checklist:
- [ ] App launches correctly
- [ ] All features work as expected
- [ ] No crashes or errors
- [ ] Network connectivity handling works
- [ ] Splash screen displays correctly
- [ ] App icon appears correctly
- [ ] Performance is acceptable

## 🔄 Updating Your App

### Version Numbering

Update version in `pubspec.yaml`:
```yaml
version: 1.0.1+2  # 1.0.1 is version name, 2 is build number
```

- Increment build number (+1) for every release
- Increment version for user-facing changes

### Release Update

1. Update version in `pubspec.yaml`
2. Update "What's New" in release notes
3. Build new release
4. Upload to respective stores
5. Submit for review

## 🔒 Security Best Practices

1. **Never commit sensitive files:**
   - `android/key.properties`
   - `*.jks` or `*.keystore` files
   - Provisioning profiles

2. **Backup your keystore:**
   - Store in a secure location
   - Keep multiple backups
   - Document passwords securely

3. **Code security:**
   - Remove all debug code
   - No hardcoded secrets or API keys
   - Use environment variables for sensitive data

## 📊 Post-Launch Monitoring

### Google Play Console
- Monitor crash reports in Android Vitals
- Respond to user reviews
- Track installation metrics
- Monitor ANR (App Not Responding) rates

### App Store Connect
- Monitor crash reports
- Respond to user reviews
- Track downloads and revenue
- Monitor app performance metrics

## 🆘 Troubleshooting

### Android Build Issues

**Issue:** Gradle build fails
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build appbundle --release
```

**Issue:** Signing errors
- Verify `key.properties` file exists and has correct values
- Check keystore file path is correct
- Ensure passwords are correct

### iOS Build Issues

**Issue:** Code signing errors
- Verify you're logged into Xcode with your Apple ID
- Check provisioning profiles are valid
- Try "Automatically manage signing"

**Issue:** Archive fails
- Clean build folder: Product > Clean Build Folder
- Delete derived data
- Restart Xcode

## 📞 Support Resources

- [Flutter Deployment Documentation](https://docs.flutter.dev/deployment)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer)
- [App Store Connect Help](https://developer.apple.com/help/app-store-connect/)
- [Flutter Community](https://flutter.dev/community)

## ✅ Final Checklist

Before submitting:
- [ ] All store listing information is complete
- [ ] Privacy policy is uploaded and URL is provided
- [ ] Screenshots are prepared for all required sizes
- [ ] App has been tested on physical devices
- [ ] Release build works correctly
- [ ] Version numbers are correct
- [ ] All compliance forms are completed
- [ ] Contact information is accurate
- [ ] Keystore is backed up securely (Android)

Good luck with your app launch! 🚀
