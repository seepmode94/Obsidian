# FLUTTER VERSIONS  
Flutter Version : flutter_windows_3.19.5-stable  
Flutter Version Ios : flutter_windows_3.32.0-stable

# 📱 On-Route Driver App (Flutter)

The **On-Route Driver** app is a Flutter-based mobile application designed to work with the OnRoute system, enabling drivers to receive live updates, share GPS data, interact with map-based services, and manage trip details efficiently.

---

## 🚀 Project Overview

### User Roles (7 Types)

1. Super Admin - User Role: 1  
2. Admin - User Role: 1  
3. Technician - User Role: 6  
4. Company Owner - User Role: 2  
5. Company Manager - User Role: 3  
6. Driver - User Role: 4  
7. Customer - User Role: 5

### Flutter SDK version (required by lockfile)

```sh  
Flutter >= 3.38.4  
Dart >= 3.10.3  
```

### Java Version

```sh  
openjdk 17.0.12  
```

### Emulator device

```sh  
Pixel 33  
```

- Built using **Flutter SDK >=3.38.4**  
- Uses **GetX** and **get_it** for state and dependency management  
- Background service for GPS & Geofence tracking  
- Firebase integration for messaging and auth  
- Custom UI components and native integrations

---

## 📦 Dependencies Highlights

- 📍 **Location Services**: `geolocator`, `location`, `flutter_background_service`, `geofence_service`  
- 📡 **Firebase**: `firebase_core`, `firebase_auth`, `firebase_messaging`, `firebase_remote_config`  
- 🌍 **Maps & Geocoding**: `google_maps_flutter`, `custom_info_window`, `geocoding`  
- 🎨 **UI Enhancements**: `flutter_svg`, `shimmer`, `persistent_bottom_nav_bar`  
- 📦 **Storage & Data**: `shared_preferences`, `flutter_secure_storage`  
- 📞 **Permissions & Device Info**: `permission_handler`, `device_info_plus`, `package_info_plus`  
- 🌐 **Network**: `dio`, `http`  
- 🛑 **Push Notifications**: `flutter_local_notifications`  
- 🌎 **Localization**: `ez_localization`  
- 🔐 **Security**: `encrypt`  
- 📊 **Charts**: `syncfusion_flutter_charts`  
- 💡 **UX Improvements**: `wakelock`, `flutter_keyboard_visibility`, `intl`, `fluttertoast`

---

## 🧭 Getting Started

### 1. Clone the Repo

```bash  
git clone git@github.com:On-Route-Project/onroute-mobile.git  
cd onroute-mobile  
```

### 2 Installs

#### Flutter and Dart installation

```bash  
sudo apt update

sudo apt install -y curl git unzip xz-utils zip libglu1-mesa

sudo apt-get update  
sudo apt-get install -y apt-transport-https wget gpg

wget -qO- [https://dl-ssl.google.com/linux/linux_signing_key.pub](https://dl-ssl.google.com/linux/linux_signing_key.pub "https://dl-ssl.google.com/linux/linux_signing_key.pub") \  
| sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg

echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] [https://storage.googleapis.com/download.dartlang.org/linux/debian](https://storage.googleapis.com/download.dartlang.org/linux/debian "https://storage.googleapis.com/download.dartlang.org/linux/debian") stable main' \  
| sudo tee /etc/apt/sources.list.d/dart_stable.list

sudo apt-get update  
sudo apt-get install -y dart

dart pub global activate fvm

echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.bashrc  
source ~/.bashrc

fvm --version

echo $SHELL  
echo $PATH  
ls -la ~/.pub-cache/bin | head

fvm install stable  
fvm global stable  
fvm flutter --version

fvm install 3.38.4  
fvm global 3.38.4

fvm flutter --version  
fvm dart --version

fvm flutter devices

fvm flutter pub get

```

#### Emulator and virtualization

##### KVM / virtualization prerequisites


```bash

sudo apt update  
sudo apt install -y qemu-kvm kvmtool libvirt-daemon-system libvirt-clients bridge-utils cpu-checker  
sudo kvm-ok

sudo usermod -aG kvm,libvirt $USER

sudo apt install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

sudo apt update  
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils cpu-checker  
sudo kvm-ok  
```

##### Java setup (assuming you use zsh)  
```bash  
sudo apt update  
sudo apt install -y openjdk-17-jdk

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"  
export PATH="$JAVA_HOME/bin:$PATH"

source ~/.zshrc  
hash -r  


export ANDROID_SDK_ROOT="$HOME/Android/Sdk"  
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools"

source ~/.zshrc  
sdkmanager --version  
```

#### Create an AVD  
```bash  
sudo apt install -y clang cmake ninja-build libgtk-3-dev  
avdmanager create avd -n pixel_api33 -k "system-images;android-33;google_apis;x86_64" -d "pixel_3"  
```

#### AVD settings  
Search for the config.ini file in your avd folder ($HOME/.android/avd/pixel_api33.avd/config.ini)  
Search for these keys and set these values

hw.keyboard=yes  
hw.dPad=no  
hw.ramSize=1536M  
disk.dataPartition.size=4G  
hw.camera.front=none  
hw.camera.back=none  
hw.cpu.ncore=8  
vm.heapSize=256M

### 3 Developing in Flutter  
#### 3.1 Developing in Android 🤖

#### 3.1.0 Run the emulator  
```bash  
~/Android/Sdk/emulator/emulator -avd pixel_api33 -gpu host -no-snapshot -no-boot-anim  
```

#### 3.1.1 Start the aplication

Inside the folder with the codebase run:

```sh  
fvm flutter run -d emulator-5554 \  
  --dart-define=ENVIRONMENT=DEV \  
  --dart-define=DEV_SERVER=[http://10.0.2.2:3001](http://10.0.2.2:3001 "http://10.0.2.2:3001/") \  
  --dart-define=DEV_API_VERSION=/api/v1  
```

#### 3.2 Developing in iOS 🍎

#### 3.2.1 Case you are already have an emulator (e.g. ios ), run

```sh  
flutter run -d E01B5D2C-E26E-4217-B3EA-1AE104F84524 \  
  --dart-define=ENVIRONMENT=DEV \  
  --dart-define=DEV_SERVER=[http://localhost:3001](http://localhost:3001 "http://localhost:3001/") \  
  --dart-define=DEV_API_VERSION=/api/v1  
```

#### Useful command to check the available emulators from the cli

> Make sure you have a device connected or an emulator running.

### 4. Generating translations strings

```sh  
dart run scripts/generate_translations.dart  
```

---  
## ⚙️ Configuration & Env Setup for deployment

#### After having the app starting in emulator  
Look for android/local.properties and add a key called  
GOOGLE_MAP_KEY=[value given by admin]

Note: This is required in order to have working maps in the app.

#### Documentation:

#### Android env variables 🤖

`android/app/my-release-key.jks`  
`android/app/upload_certificate.pem`  
`android/app/upload-keystore.jks`  
`android/local.properties`

#### Apple env variables 🍎

`ios/Flutter/Secrets.xcconfig`

### Firebase Setup (not required)

1. Download `google-services.json` (Android) and place in `android/app/`  
2. Download `GoogleService-Info.plist` (iOS) and place in `ios/Runner/`  
3. Enable Firebase services in your Firebase Console

### Google Maps API Key (not required)

Configure your API key in:  
- **Android**: `android/app/src/main/AndroidManifest.xml`  
- **iOS**: `ios/Runner/Info.plist`

---

## 🗂️ Project Structure

```bash  
.  
├── lib/  
│   ├── controllers/         # GetX controllers  
│   ├── screens/             # UI screens  
│   ├── services/            # Location, API, and Firebase services  
│   ├── utils/               # Helper functions and constants  
│   ├── widgets/             # Reusable UI components  
│   └── main.dart            # Entry point  
├── assets/                  # Fonts, icons, and images  
├── pubspec.yaml             # Project configuration  
```

---

## 🖼️ Assets & Fonts

Assets used from:

- `assets/icons/`  
- `assets/icons/svgIcons/`  
- `assets/icons/pngIcons/`  
- `assets/languages/`  
- `assets/map-style.json`

Custom font: **Manrope** in Regular, Medium, SemiBold, Bold

---

## 🌐 Environment Setup

Configure Firebase, Google Maps API key, and background services per platform (Android/iOS) using:

- `google-services.json` (Android)  
- `GoogleService-Info.plist` (iOS)  
- Background modes and permissions in `AndroidManifest.xml` and `Info.plist`

---

## 🧪 Running Tests

```bash  
flutter test  
```

---

## 📦 Build Commands

```bash  
flutter build apk    # For Android  
flutter build ios    # For iOS (macOS only)  
```

---

## 🙌 Contribution Guide

1. Fork the repo  
2. Create a branch: `git checkout -b feature/YourFeature`  
3. Commit your code: `git commit -m 'Add new feature'`  
4. Push to the branch: `git push origin feature/YourFeature`  
5. Submit a pull request

---  
## Frotcom access app

### Manager app

```sh  
unik  
```

```sh  
24Infoways!  
```

### Driver app

```sh  
gferreira  
```

```sh  
Password9000!  
```

---

## 📬 Contact

Maintainer: Guilherme Ferreira  
Email: guilhermeferreira@seepmode.com

---

## 📜 License

This project is licensed under the MIT License.