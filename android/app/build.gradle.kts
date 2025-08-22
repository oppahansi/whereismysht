import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProps = Properties().apply {
    val f = rootProject.file("key.properties")
    if (f.exists()) load(f.inputStream())
}

android {
    namespace = "de.oppahansi.lendnborrow"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "de.oppahansi.lendnborrow"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val storeFilePath = keystoreProps.getProperty("storeFile") ?: System.getenv("ANDROID_KEYSTORE")
            val storePwd = keystoreProps.getProperty("storePassword") ?: System.getenv("ANDROID_KEYSTORE_PASSWORD")
            val alias = keystoreProps.getProperty("keyAlias") ?: System.getenv("ANDROID_KEY_ALIAS")
            val keyPwd = keystoreProps.getProperty("keyPassword") ?: System.getenv("ANDROID_KEY_PASSWORD")

            require(!storeFilePath.isNullOrBlank()) { "Missing keystore path" }
            require(!storePwd.isNullOrBlank()) { "Missing store password" }
            require(!alias.isNullOrBlank()) { "Missing key alias" }
            require(!keyPwd.isNullOrBlank()) { "Missing key password" }

            storeFile = file(storeFilePath)
            storePassword = storePwd
            keyAlias = alias
            keyPassword = keyPwd
        }
    }
    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs["release"]
            isMinifyEnabled = true // Optional: disable minification, adjust as needed
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

flutter {
    source = "../.."
}
