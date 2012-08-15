package com.cocosspidermonkey;

import android.app.Activity;
import android.content.res.AssetManager;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

public class JSPlayer extends Activity {
    static private final String LOGTAG = JSPlayer.class.getCanonicalName();
    static public final String APPS_DIR_NAME = "cocosjs";

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Log.d(LOGTAG, "onCreate");

        setContentView(com.jsplayer.R.layout.mainmenu);

        LinearLayout linearlayout =
            (LinearLayout) findViewById(com.jsplayer.R.id.text_content);

        addVersionStringsToLinearLayout(linearlayout);
    }

    private void addVersionStringsToLinearLayout(LinearLayout linearlayout) {
        TextView tv = new TextView(this);

        StringBuilder content = new StringBuilder();
        content.append("Cocos JS Player\n\n");
        content.append(Bindings.getLibVersions());

        tv.setText(content);
        linearlayout.addView(tv);
    }

    public void launchScriptsActivity(View v) {
        Log.d(LOGTAG, "launching AssetsScripts...");
        Intent intent = new Intent(this, AppsList.class);
        startActivity(intent);
    }

    static {
        System.loadLibrary("cocosspidermonkeyplayer");
    }
}
