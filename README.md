# profile_card
Image Panning Assignment

# Add following code in AndroidManifest.xml for Image Croping functionality in Android

  <activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>

# Add following lines of code below for uploading image functionloty in iOS
    
<key>NSPhotoLibraryUsageDescription</key>
    <string>Upload images for screen background</string>
    <key>NSCameraUsageDescription</key>
    <string>Upload image from camera for screen background</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Post videos to profile</string>

#Install pod files in ios using following commands

# STEP 1: Install ffi
sudo arch -x86_64 gem install ffi

# STEP 2: Re-install dependencies
arch -x86_64 pod install

# Android changes might be required to install gradle to suitable version in your machine 
