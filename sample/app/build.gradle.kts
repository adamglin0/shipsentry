plugins { id("com.android.application") }

android {
    namespace = "dev.ship.risky"
    compileSdk = 35
    defaultConfig { applicationId = "dev.ship.risky"; minSdk = 24; targetSdk = 35 }
    buildTypes {
        release {
            isMinifyEnabled = false
            isDebuggable = true
        }
    }
}

