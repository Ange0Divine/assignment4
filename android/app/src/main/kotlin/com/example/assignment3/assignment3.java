package com.example.assignment3;

import android.*;
import android.os.Bundle;
import android.app.Activity;
import android.content.Context;
import android.content.Context;
import android.content.Intent;
import android.os.BatteryManager;
import android.widget.Toast;

    public class BatteryReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            int level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, 0);
            int scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, 100);
            int percentage = (level * 100) / scale;

            if (percentage >= 90) {
                // Ring and toast a message
                Toast.makeText(context, "Battery level reached 90%!", Toast.LENGTH_SHORT).show();
                // Play a ringtone
                // You can use a library like `android.media.Ringtone` to play a ringtone
            }
        }
    }
}
