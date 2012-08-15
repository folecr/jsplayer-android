package com.cocosspidermonkey;

import android.app.ListActivity;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * A list where the data for the list
 * comes from an array of strings.
 * The array of strings are the directories in the
 * "assets/cocosjs" folder
 */
public class AppsList extends ListActivity {
    static private final String LOGTAG = AppsList.class.getCanonicalName();

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Log.d(LOGTAG, "onCreate");

        CocosApp[] apps = new CocosApp[] {};
        try {
            apps = appList().toArray(apps);
        } catch (Throwable t) {
            Log.d(LOGTAG, "Exception :\n" + t);
            return;
        }

        // map an array of strings to TextViews
        setListAdapter(new ArrayAdapter<CocosApp>(this,
                                                  android.R.layout.simple_list_item_1,
                                                  apps));

        ListView lv = getListView();
        lv.setTextFilterEnabled(true);

        lv.setOnItemClickListener(new OnItemClickListener() {
                public void onItemClick(AdapterView<?> parent, View view,
                                        int position, long id) {
                    // When clicked run the app
                    CocosApp app = (CocosApp) parent.getItemAtPosition(position);
                    Log.d(LOGTAG, "Executing CocosApp " + app);
                    Bindings.execute(app);
                }
            });
    }

    private ArrayList<? extends CocosApp> appList()
        throws java.io.IOException {
        return getExternalStorageApps();
    }

    private ArrayList<CocosApp.ExternalApp> getExternalStorageApps()
        throws java.io.IOException {
        ArrayList<CocosApp.ExternalApp> apps =
            new ArrayList<CocosApp.ExternalApp>();
        
        if (isStorageReadable()) {
            File file = Environment.getExternalStorageDirectory();
            Log.d(LOGTAG, "getExternalStorageDirectory() = " + file);
            File cocosjs_apps_dir = new File(file, JSPlayer.APPS_DIR_NAME);
            String[] dir_listing = cocosjs_apps_dir.list();

            Log.d(LOGTAG, "Apps :\n --- " + cocosjs_apps_dir + "/\n      |");
            for (String name : dir_listing) {
                File entry = new File(cocosjs_apps_dir, name);
                if (entry.isDirectory()) {
                    apps.add(new CocosApp.ExternalApp(entry));
                    Log.d(LOGTAG, "      +-- " + name);
                }
            }
        }

        return apps;
    }

    private boolean isStorageReadable() {
        String state = Environment.getExternalStorageState();

        if (Environment.MEDIA_MOUNTED.equals(state) ||
            Environment.MEDIA_MOUNTED_READ_ONLY.equals(state)) {
            // We can read the media
            return true;
        } else {
            // Something else is wrong. It may be one of many other states,
            // but we can't read the media
            return false;
        }
    }
}
