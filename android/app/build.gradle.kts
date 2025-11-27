plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "duykr.studio.kujitoon"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "duykr.studio.kujitoon"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Firebase BoM (quản lý version Firebase)
    implementation(platform("com.google.firebase:firebase-bom:34.6.0"))

    // ✅ Firebase modules bạn dùng (thêm cái bạn cần)
    implementation("com.google.firebase:firebase-analytics")

    // Ví dụ nếu dùng Firebase Auth:
    // implementation("com.google.firebase:firebase-auth")

    // Nếu dùng Firestore:
    // implementation("com.google.firebase:firebase-firestore")

    // Nếu dùng Storage:
    // implementation("com.google.firebase:firebase-storage")
}