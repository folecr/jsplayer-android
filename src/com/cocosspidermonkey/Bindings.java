package com.cocosspidermonkey;

// import android.content.res.AssetManager;
import android.util.Log;

public class Bindings {
    static private final String LOGTAG = Bindings.class.getCanonicalName();

    public static StringBuilder getLibVersions() {
        StringBuilder content = new StringBuilder();

        try {
            content.append("SpiderMonkey JavaScript VM Version = " + getJSVMVersion() + "\n");
        } catch (Throwable t) {
            Log.d(LOGTAG, "Exception : " + t);
            content.append("Error obtaining JavaScript VM version information.\n");
        }

        try {
            content.append("Bindings Version = " + getCocosVersion() + "\n");
        } catch (Throwable t) {
            Log.d(LOGTAG, "Exception : " + t);
            content.append("Error obtaining Cocos version information.\n");
        }

        return content;
    }

    public static void execute(CocosApp app) {
        Log.d(LOGTAG, "Executing CocosJS app : " + app);

        if (app instanceof CocosApp.ExternalApp) {
            CocosApp.ExternalApp eapp = (CocosApp.ExternalApp) app;
            runAppFromFileSystem(eapp.root.getAbsolutePath());
        } else {
            Log.d(LOGTAG, "CocosJS Bindings can only run apps from the external file system");
            throw new RuntimeException("CocosJS Bindings can only run apps from the external file system");
        }
    }

    private static native String getJSVMVersion();
    // static native void   jsvmDiagnostics();
    private static native void runAppFromFileSystem(String path);

    private static native String getCocosVersion();
    // private static native void   cocosDiagnostics();
}
