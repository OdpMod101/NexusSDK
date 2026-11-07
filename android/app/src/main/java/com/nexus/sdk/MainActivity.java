package com.nexus.sdk;

import android.app.Activity;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Button;
import android.widget.Toast;
import android.view.View;

public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Tworzymy prosty, czysty interfejs launchera
        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setPadding(50, 50, 50, 50);

        TextView title = new TextView(this);
        title.setText("NexusSDK Launcher v1.0.0");
        title.setTextSize(24);
        layout.addView(title);

        TextView status = new TextView(this);
        status.setText("\nStatus: Gotowy do działania\n");
        status.setTextSize(16);
        layout.addView(status);

        Button launchBtn = new Button(this);
        launchBtn.setText("Uruchom Geometry Dash z modami");
        layout.addView(launchBtn);

        setContentView(layout);

        try {
            // Automatyczne ładowanie Twojego pliku .so przy starcie programu
            System.loadLibrary("nexus_core");
            Toast.makeText(this, "Silnik NexusSDK załadowany!", Toast.LENGTH_SHORT).show();
        } catch (UnsatisfiedLinkError e) {
            status.setText("\nStatus: Błąd ładowania rdzenia systemowego.\n");
            Toast.makeText(this, "Błąd .so: " + e.getMessage(), Toast.LENGTH_LONG).show();
        }
    }
}
