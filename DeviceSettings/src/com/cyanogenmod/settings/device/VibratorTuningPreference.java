/*
 * Copyright (C) 2011 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.cyanogenmod.settings.device;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Vibrator;
import android.preference.DialogPreference;
import android.preference.PreferenceManager;
import android.util.AttributeSet;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.SeekBar;
import android.widget.TextView;

/**
 * Special preference type that allows configuration of both the ring volume and
 * notification volume.
 */
public class VibratorTuningPreference extends DialogPreference implements OnClickListener {

    private static final String TAG = "vibrator...";

    private static final int SEEKBAR_ID = R.id.vibrator_seekbar;

    private static final int VALUE_DISPLAY_ID = R.id.vibrator_value;

    private static final String FILE_PATH = "/sys/class/misc/pwm_duty/pwm_duty";

    private VibrationSeekBar mSeekBar = new VibrationSeekBar();

    private static final int MAX_VALUE = 100;

    private static final int OFFSET_VALUE = 0;

    // Track instances to know when to restore original color
    // (when the orientation changes, a new dialog is created before the old one
    // is destroyed)
    private static int sInstances = 0;

    public VibratorTuningPreference(Context context, AttributeSet attrs) {
        super(context, attrs);

        setDialogLayoutResource(R.layout.preference_dialog_vibrator_tuning);
    }

    @Override
    protected void onBindDialogView(View view) {
        super.onBindDialogView(view);

        sInstances++;

        SeekBar seekBar = (SeekBar) view.findViewById(SEEKBAR_ID);
        TextView valueDisplay = (TextView) view.findViewById(VALUE_DISPLAY_ID);
        mSeekBar = new VibrationSeekBar(seekBar, valueDisplay, FILE_PATH);

        SetupButtonClickListener(view);
    }

    private void SetupButtonClickListener(View view) {
            Button mDefaultButton = (Button)view.findViewById(R.id.btnvibratorDefault);
            mDefaultButton.setOnClickListener(this);

            Button mTestButton = (Button)view.findViewById(R.id.btnvibratorTest);
            mTestButton.setOnClickListener(this);
    }

    @Override
    protected void onDialogClosed(boolean positiveResult) {
        super.onDialogClosed(positiveResult);

        sInstances--;

        if (positiveResult) {
            mSeekBar.save();
        } else if (sInstances == 0) {
            mSeekBar.reset();
        }
    }

    public static void restore(Context context) {
        if (!isSupported()) {
            return;
        }

        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);
        int value = sharedPrefs.getInt(FILE_PATH, MAX_VALUE);
        Utils.writeValue(FILE_PATH, String.valueOf(value));
    }

    public static boolean isSupported() {
        boolean supported = true;
        if (!Utils.fileExists(FILE_PATH)) {
            supported = false;
        }

        return supported;
    }

    class VibrationSeekBar implements SeekBar.OnSeekBarChangeListener {

        protected String mFilePath;
        protected int mOriginal;
        protected SeekBar mSeekBar;
        protected TextView mValueDisplay;

        public VibrationSeekBar(SeekBar seekBar, TextView valueDisplay, String filePath) {
            mSeekBar = seekBar;
            mValueDisplay = valueDisplay;
            mFilePath = filePath;

            // Read original value
            SharedPreferences sharedPreferences = getSharedPreferences();
            mOriginal = sharedPreferences.getInt(mFilePath, MAX_VALUE);

            seekBar.setMax(MAX_VALUE);
            reset();
            seekBar.setOnSeekBarChangeListener(this);
        }

        // For inheriting class
        protected VibrationSeekBar() {
        }

        public void reset() {
            mSeekBar.setProgress(mOriginal);
            updateValue(mOriginal);
        }

        public void save() {
            Editor editor = getEditor();
            editor.putInt(mFilePath, mSeekBar.getProgress());
            editor.commit();
        }

        @Override
        public void onProgressChanged(SeekBar seekBar, int progress,
                boolean fromUser) {
            Utils.writeValue(mFilePath, String.valueOf(progress));
            updateValue(progress);
        }

        @Override
        public void onStartTrackingTouch(SeekBar seekBar) {
            // Do nothing
        }

        @Override
        public void onStopTrackingTouch(SeekBar seekBar) {
            // Do nothing
        }

        private void updateValue(int progress) {
            mValueDisplay.setText(String.format("%d", (int) progress));
        }

        public void resetDefault() {
            mSeekBar.setProgress(MAX_VALUE);
            updateValue(MAX_VALUE);
            Utils.writeValue(mFilePath, String.valueOf(MAX_VALUE));
        }
    }

    public void onClick(View v) {
        switch(v.getId()){
            case R.id.btnvibratorTest:
                testVibration();
                break;
            case R.id.btnvibratorDefault:
                mSeekBar.resetDefault();
                break;
        }
    }

    public void testVibration() {
        Vibrator vib = (Vibrator) this.getContext().getSystemService(Context.VIBRATOR_SERVICE);
        vib.vibrate(1000);
    }

}
