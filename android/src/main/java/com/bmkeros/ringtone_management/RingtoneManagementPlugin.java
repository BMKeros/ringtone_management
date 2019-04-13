package com.bmkeros.ringtone_management;

import android.content.Context;
import android.database.Cursor;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.speech.RecognizerIntent;
import android.util.Log;

import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * RingtoneManagementPlugin
 */
public class RingtoneManagementPlugin implements MethodCallHandler {

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "ringtone_management");
        channel.setMethodCallHandler(new RingtoneManagementPlugin(registrar.context()));
    }

    private final Context context;
    private List<Ringtone> listRingtones;
    private List<String> listTitles;
    private int ringtoneType;


    RingtoneManagementPlugin(Context context) {
        this.context = context;
        this.listRingtones = null;
        this.listTitles = null;
        this.ringtoneType = RingtoneManager.TYPE_RINGTONE;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {

        switch (call.method) {
            case "ringtone:get_ringtones_title":
                if (this.listTitles == null) {
                    this.listTitles = this.getRingtonesTitle();
                }
                result.success(this.listTitles);
                break;
            case "ringtone:get_ringtones_data":
                result.success(this.getRingtonesData());
                break;
            case "ringtone:set_ringtone_type":
                int type = (int) call.argument("type");
                this.setRingtoneType(type);
                result.success(null);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void setRingtoneType(int type) {
        this.ringtoneType = type;
    }

    private List<String> getRingtonesTitle() {
        if (this.listRingtones == null) {
            this.listRingtones = this.getRingtonesAvailables();
        }
        List<Ringtone> ringtones = this.listRingtones;
        List<String> titles = new ArrayList<>();

        assert ringtones != null;

        for (Ringtone currentRingtone : ringtones) {
            titles.add(currentRingtone.getTitle(this.context));
        }
        return titles;
    }

    private List<Ringtone> getRingtonesAvailables() {
        RingtoneManager manager = new RingtoneManager(this.context);
        manager.setType(this.ringtoneType);

        Cursor cursor = manager.getCursor();
        int total = cursor.getCount();

        if (total == 0 && !cursor.moveToFirst()) {
            return null;
        }
        List<Ringtone> ringtones = new ArrayList<>();

        while (!cursor.isAfterLast() && cursor.moveToNext()) {

            int currentPosition = cursor.getPosition();

            ringtones.add(manager.getRingtone(currentPosition));
        }
        cursor.close();

        return ringtones;
    }

    private List<HashMap<String, String>> getRingtonesData() {
        RingtoneManager manager = new RingtoneManager(this.context);
        manager.setType(this.ringtoneType);

        Cursor cursor = manager.getCursor();
        int total = cursor.getCount();

        if (total == 0 && !cursor.moveToFirst()) {
            return null;
        }
        List<HashMap<String, String>> data = new ArrayList<>();

        while (!cursor.isAfterLast() && cursor.moveToNext()) {
            Uri uri = manager.getRingtoneUri(cursor.getPosition());
            Ringtone ringtone = manager.getRingtone(cursor.getPosition());

            HashMap<String, String> map = new HashMap<>();
            map.put("title", ringtone.getTitle(this.context));
            map.put("uri", uri.toString());

            data.add(map);
        }
        cursor.close();

        return data;
    }
}
