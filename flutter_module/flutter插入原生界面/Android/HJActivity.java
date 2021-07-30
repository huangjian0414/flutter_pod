package com.example.flutter_module.host;
import android.content.Context;
import android.view.View;
import android.widget.TextView;

import io.flutter.plugin.platform.PlatformView;

public class HJActivity implements PlatformView {

    private final TextView myView;

    HJActivity(Context context) {
        TextView myView = new TextView(context);
        myView.setText("Android-View");
        this.myView = myView;
    }
    @Override
    public View getView() {

        return myView;
    }

    @Override
    public void dispose() {

    }
}