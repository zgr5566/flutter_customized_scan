package com.zgr.flutter_customized_scan;

import android.content.Context;
import android.graphics.Color;
import android.graphics.Rect;
import android.os.Build;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.huawei.hms.hmsscankit.OnResultCallback;
import com.huawei.hms.hmsscankit.RemoteView;
import com.huawei.hms.ml.scan.HmsScan;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class CustomizedScanViewFactory extends PlatformViewFactory {

    private final BinaryMessenger messenger;

    public CustomizedScanViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new CustomizedScanView(context, viewId, messenger);
    }


    private static class CustomizedScanView implements PlatformView, MethodChannel.MethodCallHandler {

        private final FrameLayout frameLayout;
        private final RemoteView remoteView;
        private final MethodChannel methodChannel;

        public CustomizedScanView(Context context, int viewId, BinaryMessenger messenger) {
            methodChannel = new MethodChannel(messenger, "flutter_customized_scan_" + viewId);
            methodChannel.setMethodCallHandler(this);

            // 设置扫码识别区域，您可以按照需求调整参数。
            DisplayMetrics dm = context.getResources().getDisplayMetrics();
            float density = dm.density;
            int mScreenWidth = context.getResources().getDisplayMetrics().widthPixels;
            int mScreenHeight = context.getResources().getDisplayMetrics().heightPixels;
            // 当前Demo扫码框的宽高是300dp。
            final int SCAN_FRAME_SIZE = 300;
            int scanFrameSize = (int) (SCAN_FRAME_SIZE * density);
            Rect rect = new Rect();
            rect.left = mScreenWidth / 2 - scanFrameSize / 2;
            rect.right = mScreenWidth / 2 + scanFrameSize / 2;
            rect.top = mScreenHeight / 2 - scanFrameSize / 2;
            rect.bottom = mScreenHeight / 2 + scanFrameSize / 2;

            frameLayout = new FrameLayout(context);
            frameLayout.setBackgroundColor(Color.parseColor("#FFFFFF"));
            frameLayout.setId(viewId);

            remoteView = new RemoteView.Builder()
                    .setContext(FlutterCustomizedScanPlugin.activityWR.get())
                    .setBoundingBox(rect)
                    .setContinuouslyScan(true)
                    .build();

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
                remoteView.setId(View.generateViewId());
            }

            remoteView.setOnResultCallback(new OnResultCallback() {
                @Override
                public void onResult(HmsScan[] hmsScans) {
                    if(hmsScans == null){
                        return;
                    }
                    HmsScan scan = hmsScans[hmsScans.length - 1];
                    if(scan == null){
                        return;
                    }
                    String result = scan.getShowResult();
                    try{
                        methodChannel.invokeMethod("result",result);
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                }
            });

            remoteView.onCreate(null);

            frameLayout.addView(remoteView,new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT,FrameLayout.LayoutParams.MATCH_PARENT));
        }

        @Override
        public View getView() {
            remoteView.onStart();
            return frameLayout;
        }

        @Override
        public void dispose() {
            remoteView.onDestroy();
        }

        @Override
        public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
            
        }
    }
}


