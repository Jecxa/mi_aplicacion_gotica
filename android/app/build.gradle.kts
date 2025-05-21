plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services") // 👈 agregado para Firebase
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.mi_aplicacion_gotica"
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
        applicationId = "com.example.mi_aplicacion_gotica"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:32.7.2")) // 👈 BOM para versiones automáticas
    implementation("com.google.firebase:firebase-analytics") // 👈 Firebase Analytics
}
