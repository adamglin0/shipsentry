package dev.ship.risky

import android.util.Log
import android.webkit.WebView

class MainActivity {
    fun configure(webView: WebView, bridge: Any) {
        // TODO: remove test bridge before release.
        webView.settings.allowFileAccess = true
        webView.addJavascriptInterface(bridge, "Native")
        Log.d("RiskySample", "configured")
    }
}

