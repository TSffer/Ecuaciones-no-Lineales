REM Adjust these paths to yours
SET PATH=c:\laztoapk\downloads\android-sdk-windows\tools;c:\laztoapk\downloads\android-sdk-windows\platform-tools;C:\Program Files\Java\jdk1.8.0_112\bin;
SET APP_NAME=applicaciones
SET ANDROID_HOME="c:\laztoapk\downloads\android-sdk-windows"
SET APK_SDK_PLATFORM="c:\laztoapk\downloads\android-sdk-windows\platforms\android-22"
SET APK_PROJECT_PATH=C:\laztoapk\applicaciones\android
SET SDK_BUILDTOOLS=27.0.3
SET PASSWORD=test12

mkdir %APK_PROJECT_PATH%\bin

keytool -genkey -v -keystore %APK_PROJECT_PATH%\bin\LCLDebugKey.keystore -alias LCLDebugKey -keyalg RSA -validity 10000

