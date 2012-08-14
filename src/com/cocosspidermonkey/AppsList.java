package com.cocosspidermonkey;

import android.app.ListActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.IOException;

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

        // map an array of strings to TextViews
        setListAdapter(new ArrayAdapter<String>(this,
                                                android.R.layout.simple_list_item_1,
                                                appList()));

        ListView lv = getListView();
        lv.setTextFilterEnabled(true);

        lv.setOnItemClickListener(new OnItemClickListener() {
                public void onItemClick(AdapterView<?> parent, View view,
                                        int position, long id) {
                    CharSequence path = ((TextView) view).getText();

                    // When clicked run the app
                    Log.d(LOGTAG, "Executing app " + path);
                    // Bindings.executeJS(getAssets(), "cocosjs/" + path.toString());
                }
            });
    }

    private String[] appList() {
        try {
            String[] apps = getApps();

            Log.d(LOGTAG, "Apps :\n --- cocosjs/\n      |");
            for (String s: apps) {
                Log.d(LOGTAG, "      +-- " + s);
            }

            return apps;
        } catch (java.io.IOException ioe) {
            Log.d(LOGTAG, "Exception reading apps from assets/cocosjs.\n" + ioe);
            return(new String[] {});
        }
    }

    private String[] getApps() throws java.io.IOException {
        String[] assetList = getAssets().list("cocosjs");
        return assetList;
    }
}
