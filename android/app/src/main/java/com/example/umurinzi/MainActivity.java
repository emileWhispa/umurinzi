package com.example.umurinzi;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.widget.Toast;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "app.channel.shared.data";


    void toast(String string){
        Toast.makeText(this,string,Toast.LENGTH_LONG).show();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            // TODO
                            if( call.method.equals("toast") ){
                                toast(call.arguments.toString());
                            }
                        }
                );
    }
}
