package com.example.flutter_module.host;
import android.content.Context;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class HJPlatformFactory extends PlatformViewFactory {

    /**
     * @param createArgsCodec the codec used to decode the args parameter of {@link #create}.
     */
    public HJPlatformFactory(MessageCodec<Object> createArgsCodec) {
        super(createArgsCodec);
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new HJActivity(context);
    }
}

