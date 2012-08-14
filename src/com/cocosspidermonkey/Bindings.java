package com.cocosspidermonkey;

import android.content.res.AssetManager;
import android.util.Log;

public class Bindings {
    static private final String LOGTAG = Bindings.class.getCanonicalName();

    public static StringBuilder getLibVersions() {
        StringBuilder content = new StringBuilder();

        try {
            content.append("SpiderMonkey JavaScript VM Version = " + getJSVMVersion() + "\n");
        } catch (Throwable t) {
            Log.d(LOGTAG, "Exception : " + t);
            content.append("Error obtaining SpiderMonkey JavaScript VM version information.\n");
        }

        try {
            content.append("Bindings Version = " + getBindingsVersion() + "\n");
        } catch (Throwable t) {
            Log.d(LOGTAG, "Exception : " + t);
            content.append("Error obtaining SpiderMonkey JavaScript bindings version information.\n");
        }

        return content;
    }

    public static void executeJS(AssetManager assetmanager,
                                 String relativePath) {
        Log.d(LOGTAG, "executeJS assets/" + relativePath);

        runJSFromAssets(assetmanager, relativePath);
    }

    private static native String getJSVMVersion();
    private static native void   jsvmDiagnostics();
    private static native void   runJSFromAssets(AssetManager a,
                                                 String s);

    private static native String getBindingsVersion();
    private static native void   bindingsDiagnostics();
}
